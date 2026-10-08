"""Replace the lab's Python source while retaining bundled Linux dependencies.

Run from the extracted source bundle after verify_inventory.py succeeds:
    python3 package_logic.py
Upload inventory-reporter-custom.zip in OCI Console.
"""
from pathlib import Path
import zipfile

BASE = Path(__file__).resolve().parent
destination = BASE / "inventory-reporter-custom.zip"
template = BASE / "inventory-reporter.zip"
if not template.is_file():
    raise SystemExit("The supplied inventory-reporter.zip must be beside this script.")
replacement_names = {f"function/{name}" for name in ("func.py", "inventory.py", "requirements.txt", "func.yaml")}
with zipfile.ZipFile(template) as source, zipfile.ZipFile(destination, "w", zipfile.ZIP_DEFLATED) as output:
    for entry in source.infolist():
        if entry.filename not in replacement_names:
            output.writestr(entry, source.read(entry.filename))
    for name in ("func.py", "inventory.py", "requirements.txt", "func.yaml"):
        output.write(BASE / "function" / name, f"function/{name}")
print(f"Created {destination.name}. Runtime: python312.ol9; handler: func.handler.")
