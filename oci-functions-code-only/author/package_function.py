"""Build a code-only archive inside Linux/Python 3.12.

The managed runtime supplies FDK but does NOT install requirements.txt. Vendor
OCI and its dependencies under function/ alongside the source. Mount this lab
at /lab in the official python:3.12-slim container when running this script.
"""
from pathlib import Path
import ast
import os
import subprocess
import sys
import tempfile
import zipfile

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / "deploy-function" / "files" / "function"
target = Path(tempfile.mkdtemp(prefix="inventory-lab-sdk-"))
archive_path = ROOT / "deploy-function" / "files" / "inventory-reporter.zip"
if "--reuse-archive" in sys.argv:
    # Reuse the already-built Linux wheels, never packages from the host OS.
    with zipfile.ZipFile(archive_path) as existing:
        tree = ast.parse(existing.read("function/oci/__init__.py"))
        exports = next(ast.literal_eval(node.value) for node in ast.walk(tree)
                       if isinstance(node, ast.Assign)
                       and any(isinstance(t, ast.Name) and t.id == "__all__" for t in node.targets))
        # Shared pagination/waiter helpers import DNS and Work Requests models.
        retained = set(exports[:exports.index("access_governance_cp")]) | {"object_storage", "dns", "work_requests"}
        excluded_services = set(exports) - retained
        for member in existing.infolist():
            parts = Path(member.filename).parts
            if len(parts) > 3 and parts[:2] == ("function", "oci") and parts[2] in excluded_services:
                continue
            existing.extract(member, target)
    target = target / "function"
else:
    subprocess.run([sys.executable, "-m", "pip", "install", "--disable-pip-version-check",
                    "--no-cache-dir", "--target", str(target), "oci==2.182.1"], check=True)
# The SDK contains hundreds of unrelated services. Keep its shared helpers and
# Object Storage intact, excluding other service packages (not editing SDK code).
tree = ast.parse((target / "oci" / "__init__.py").read_text())
exports = next(ast.literal_eval(node.value) for node in ast.walk(tree)
               if isinstance(node, ast.Assign)
               and any(isinstance(t, ast.Name) and t.id == "__all__" for t in node.targets))
shared = set(exports[:exports.index("access_governance_cp")]) | {"object_storage", "dns", "work_requests"}
excluded = set(exports) - shared
candidate = archive_path.with_suffix(".building.zip")
with zipfile.ZipFile(candidate, "w", compression=zipfile.ZIP_DEFLATED, compresslevel=9) as archive:
    for path in sorted(target.rglob("*")):
        parts = path.relative_to(target).parts
        if len(parts) > 2 and parts[0] == "oci" and parts[1] in excluded:
            continue
        if len(parts) == 1 and parts[0] in ("func.py", "inventory.py", "requirements.txt", "func.yaml"):
            continue
        if path.is_file() and "__pycache__" not in path.parts and path.suffix != ".pyc":
            archive.write(path, "function/" + path.relative_to(target).as_posix())
    for filename in ("func.py", "inventory.py", "requirements.txt", "func.yaml"):
        archive.write(SOURCE / filename, f"function/{filename}")
verification = Path(tempfile.mkdtemp(prefix="inventory-lab-check-"))
with zipfile.ZipFile(candidate) as archive:
    archive.extractall(verification)
env = dict(os.environ, PYTHONPATH=str(verification / "function"))
subprocess.run([sys.executable, str(ROOT / "author" / "test_packaged_sdk.py")],
               env=env, cwd=verification, check=True)
candidate.replace(archive_path)
print(f"Archive: {archive_path}; {archive_path.stat().st_size} bytes", flush=True)
