"""Build deterministic fixture variants, expected outputs, and a source bundle."""

import importlib.util
import shutil
from pathlib import Path
import zipfile

ROOT = Path(__file__).resolve().parents[1]
FILES = ROOT / "deploy-function" / "files"
original = (FILES / "inventory-run1.csv").read_text(encoding="utf-8")
variants = {
    "inventory-run2.csv": original,
    "inventory-bad.csv": original.replace("INV-007,ab-107,PHX,12", "INV-007,ab-107,PHX,twelve"),
    "inventory-fixed.csv": original,
}
for name, contents in variants.items():
    (FILES / name).write_text(contents, encoding="utf-8", newline="\n")

spec = importlib.util.spec_from_file_location("inventory", FILES / "function" / "inventory.py")
inventory = importlib.util.module_from_spec(spec)
spec.loader.exec_module(inventory)
for name, threshold in (("inventory-run1", 10), ("inventory-run2", 20), ("inventory-bad", 20), ("inventory-fixed", 20)):
    reports = inventory.process_inventory((FILES / f"{name}.csv").read_text(), threshold)
    destination = FILES / "expected" / name
    destination.mkdir(parents=True, exist_ok=True)
    for report_name, contents in zip(("restock-report.csv", "rejected-records.csv"), reports):
        (destination / report_name).write_text(contents, encoding="utf-8", newline="\n")

with zipfile.ZipFile(FILES / "inventory-lab-source.zip", "w", zipfile.ZIP_DEFLATED) as archive:
    for path in sorted(FILES.rglob("*")):
        if path.is_file() and (path.suffix != ".zip" or path.name == "inventory-reporter.zip") and "__pycache__" not in path.parts:
            archive.write(path, path.relative_to(FILES).as_posix())
print("Built four input fixtures, expected reports, and inventory-lab-source.zip")

# Keep the optional lab's local downloads aligned with the canonical fixtures.
optional_files = ROOT / "configure-troubleshoot" / "files"
optional_files.mkdir(parents=True, exist_ok=True)
for stem in ("inventory-run2", "inventory-bad", "inventory-fixed"):
    shutil.copy2(FILES / f"{stem}.csv", optional_files / f"{stem}.csv")
    shutil.copytree(FILES / "expected" / stem, optional_files / "expected" / stem, dirs_exist_ok=True)
print("Synchronized optional Lab 2 CSVs and expected reports")
