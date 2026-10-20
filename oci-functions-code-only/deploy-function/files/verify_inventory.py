"""Run locally or in Cloud Shell: python3 verify_inventory.py."""

import csv
import importlib.util
import io
from pathlib import Path
import unittest

BASE = Path(__file__).resolve().parent
spec = importlib.util.spec_from_file_location("inventory", BASE / "function" / "inventory.py")
inventory = importlib.util.module_from_spec(spec)
spec.loader.exec_module(inventory)
process_inventory = inventory.process_inventory
HEADER = "record_id,sku,warehouse,quantity\n"


def rows(text):
    return list(csv.DictReader(io.StringIO(text)))


class InventoryChecks(unittest.TestCase):
    def test_supplied_files(self):
        for name, threshold, expected_good, expected_bad in (
            ("inventory-run1.csv", 10, 5, 0),
            ("inventory-run2.csv", 20, 11, 0),
            ("inventory-bad.csv", 20, 10, 1),
            ("inventory-fixed.csv", 20, 11, 0),
        ):
            with self.subTest(name=name):
                source = (BASE / name).read_text(encoding="utf-8")
                self.assertEqual(len(rows(source)), 20)
                restock, rejected = process_inventory(source, threshold)
                self.assertEqual(len(rows(restock)), expected_good)
                self.assertEqual(len(rows(rejected)), expected_bad)
                if expected_bad:
                    self.assertEqual(rows(rejected), [{"record_id": "INV-007", "reason": "invalid_quantity"}])
                else:
                    self.assertEqual(rejected, "record_id,reason\n")
        first, _ = process_inventory((BASE / "inventory-run1.csv").read_text())
        self.assertEqual([r["record_id"] for r in rows(first)], [f"INV-{i:03}" for i in range(1, 6)])
        self.assertEqual(rows(first)[0], {"record_id": "INV-001", "sku": "AB-101", "warehouse": "PHX", "quantity": "2"})

    def test_boundaries(self):
        source = HEADER + "zero,a,b,0\nleading,a,b,0009\nten,a,b,10\n"
        good, bad = process_inventory(source)
        self.assertEqual([r["quantity"] for r in rows(good)], ["0", "9"])
        self.assertEqual(rows(bad), [])
        self.assertEqual(process_inventory(source, 0)[0], HEADER)

    def test_row_rejections_do_not_stop_processing(self):
        source = HEADER + "negative,a,b,-1\ndecimal,a,b,2.5\nword,a,b,twelve\nblank,,b,5\nshort,a,b\nextra,a,b,1,x\nvalid,a,b,2\n"
        good, bad = process_inventory(source)
        self.assertEqual([r["record_id"] for r in rows(good)], ["valid"])
        self.assertEqual([r["reason"] for r in rows(bad)], ["invalid_quantity"] * 3 + ["missing_value", "invalid_column_count", "invalid_column_count"])

    def test_quoted_fields_and_bom(self):
        good, _ = process_inventory('\ufeff' + HEADER + 'x," ab,1 "," phx ",2\n')
        self.assertEqual(rows(good)[0]["sku"], "AB,1")

    def test_header_only_and_invalid_header(self):
        self.assertEqual(process_inventory(HEADER), (HEADER, "record_id,reason\n"))
        for source in ("", "sku,warehouse,quantity\n", "record_id,sku,sku,quantity\n"):
            with self.assertRaises(ValueError):
                process_inventory(source)

    def test_invalid_threshold(self):
        for threshold in (-1, 1.5, True, "10"):
            with self.assertRaises(ValueError):
                process_inventory(HEADER, threshold)


if __name__ == "__main__":
    unittest.main(verbosity=2)
