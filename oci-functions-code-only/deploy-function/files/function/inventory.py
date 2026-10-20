"""The small, standard-library-only module learners can generate with AI."""

import csv
import io
import re

FIELDS = ["record_id", "sku", "warehouse", "quantity"]


def process_inventory(csv_text, threshold=10):
    """Return (restock_csv, rejected_csv). Reject bad rows, never coerce to zero."""
    if type(threshold) is not int or threshold < 0:
        raise ValueError("threshold must be a nonnegative integer")
    reader = csv.DictReader(io.StringIO(csv_text.lstrip("\ufeff")), strict=True)
    if reader.fieldnames != FIELDS:
        raise ValueError("CSV header must be record_id,sku,warehouse,quantity")

    restock_output = io.StringIO(newline="")
    rejected_output = io.StringIO(newline="")
    restock = csv.DictWriter(restock_output, fieldnames=FIELDS, lineterminator="\n")
    rejected = csv.DictWriter(
        rejected_output, fieldnames=["record_id", "reason"], lineterminator="\n"
    )
    restock.writeheader()
    rejected.writeheader()

    for row in reader:
        record_id = (row.get("record_id") or "").strip()
        reason = None
        if None in row or any(row.get(field) is None for field in FIELDS):
            reason = "invalid_column_count"
        elif any(not row[field].strip() for field in FIELDS):
            reason = "missing_value"
        elif not re.fullmatch(r"[0-9]+", row["quantity"].strip()):
            reason = "invalid_quantity"
        if reason:
            rejected.writerow({"record_id": record_id, "reason": reason})
            continue

        quantity = int(row["quantity"].strip())
        if quantity < threshold:
            restock.writerow({
                "record_id": record_id,
                "sku": row["sku"].strip().upper(),
                "warehouse": row["warehouse"].strip().upper(),
                "quantity": quantity,
            })

    return restock_output.getvalue(), rejected_output.getvalue()
