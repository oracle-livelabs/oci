"""Local integration-contract tests with fake Object Storage (no cloud calls)."""
import copy
import importlib.util
import json
from pathlib import Path
import sys
import types
import unittest

FILES = Path(__file__).resolve().parents[1] / "deploy-function" / "files"
sys.path.insert(0, str(FILES / "function"))
sys.modules.setdefault("oci", types.ModuleType("oci"))
fdk_stub = types.ModuleType("fdk")
fdk_stub.response = types.SimpleNamespace()
sys.modules.setdefault("fdk", fdk_stub)
import func


class Storage:
    def __init__(self, text):
        self.content = text.encode("utf-8")
        self.outputs = {}
        self.reads = []

    def get_object(self, namespace, bucket, name):
        self.reads.append((namespace, bucket, name))
        return types.SimpleNamespace(data=types.SimpleNamespace(content=self.content))

    def put_object(self, namespace, bucket, name, body, **kwargs):
        self.outputs[(namespace, bucket, name)] = body


class AdapterChecks(unittest.TestCase):
    def setUp(self):
        self.event = {
            "eventType": "com.oraclecloud.objectstorage.createobject", "eventID": "local-test",
            "data": {"resourceName": "inventory-run1.csv", "additionalDetails": {
                "bucketName": "incoming", "namespace": "labnamespace",
            }},
        }
        self.settings = dict(input_bucket="incoming", output_bucket="output", namespace="labnamespace", threshold=10)
        self.client = Storage((FILES / "inventory-run1.csv").read_text())

    def test_event_creates_expected_reports_and_repeats_safely(self):
        for attempt in range(2):
            result = func.process_event(self.event, self.client, **self.settings)
            self.assertEqual((result["restock_count"], result["rejected_count"]), (5, 0))
            self.assertEqual(len(self.client.outputs), 2)
            for report in ("restock-report.csv", "rejected-records.csv"):
                actual = self.client.outputs[("labnamespace", "output", f"inventory-run1/{report}")].decode()
                self.assertEqual(actual, (FILES / "expected" / "inventory-run1" / report).read_text())

    def test_other_events_and_output_bucket_are_ignored(self):
        cases = [copy.deepcopy(self.event) for _ in range(4)]
        cases[0]["eventType"] = "com.oraclecloud.objectstorage.updateobject"
        cases[1]["data"]["additionalDetails"]["bucketName"] = "output"
        cases[2]["data"]["additionalDetails"]["namespace"] = "anothernamespace"
        cases[3]["data"]["resourceName"] = "readme.txt"
        for event in cases:
            self.assertEqual(func.process_event(event, self.client, **self.settings)["status"], "ignored")
        self.assertEqual(self.client.reads, [])
        self.assertEqual(self.client.outputs, {})

    def test_bad_file_keeps_valid_rows(self):
        self.client = Storage((FILES / "inventory-bad.csv").read_text())
        self.settings["threshold"] = 20
        self.event["data"]["resourceName"] = "inventory-bad.csv"
        result = func.process_event(self.event, self.client, **self.settings)
        self.assertEqual((result["restock_count"], result["rejected_count"]), (10, 1))

    def test_same_bucket_configuration_fails(self):
        self.settings["output_bucket"] = "incoming"
        with self.assertRaises(ValueError):
            func.process_event(self.event, self.client, **self.settings)


if __name__ == "__main__":
    unittest.main(verbosity=2)
