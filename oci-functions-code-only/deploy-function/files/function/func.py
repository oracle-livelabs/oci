"""OCI adapter: learners replace inventory.py, leaving this integration intact."""

import csv
import io
import json
import os
from pathlib import PurePosixPath

import oci
from fdk import response

from inventory import process_inventory


def log(message, **fields):
    print(json.dumps({"message": message, **fields}), flush=True)


def process_event(event, client, *, input_bucket, output_bucket, namespace, threshold):
    if event.get("eventType") != "com.oraclecloud.objectstorage.createobject":
        return {"status": "ignored", "reason": "not_object_create"}
    data = event.get("data", {})
    details = data.get("additionalDetails", {})
    source = data.get("resourceName", "")
    if details.get("bucketName") != input_bucket or details.get("namespace") != namespace:
        return {"status": "ignored", "reason": "not_lab_input_bucket"}
    if not source.lower().endswith(".csv"):
        return {"status": "ignored", "reason": "not_csv"}
    if input_bucket == output_bucket:
        raise ValueError("Input and output buckets must be different")

    log("processing_started", source_file=source, event_id=event.get("eventID"))
    obj = client.get_object(namespace, input_bucket, source)
    csv_text = obj.data.content.decode("utf-8-sig")
    restock_csv, rejected_csv = process_inventory(csv_text, threshold)
    # Keep the source path; a repeated delivery replaces the same two reports.
    prefix = str(PurePosixPath(source).with_suffix(""))
    for report_name, content in (
        ("restock-report.csv", restock_csv),
        ("rejected-records.csv", rejected_csv),
    ):
        client.put_object(
            namespace, output_bucket, f"{prefix}/{report_name}",
            content.encode("utf-8"), content_type="text/csv; charset=utf-8",
        )
    restock_rows = list(csv.DictReader(io.StringIO(restock_csv)))
    rejected_rows = list(csv.DictReader(io.StringIO(rejected_csv)))
    for row in rejected_rows:
        log("record_rejected", source_file=source, **row)
    result = {
        "status": "processed", "source_file": source, "output_prefix": prefix,
        "threshold": threshold, "restock_count": len(restock_rows),
        "rejected_count": len(rejected_rows),
    }
    log("reports_written", **result)
    return result


def handler(ctx, data: io.BytesIO = None):
    try:
        event = json.loads(data.getvalue()) if data else {}
        signer = oci.auth.signers.get_resource_principals_signer()
        client = oci.object_storage.ObjectStorageClient(
            config={}, signer=signer, retry_strategy=oci.retry.DEFAULT_RETRY_STRATEGY
        )
        result = process_event(
            event, client,
            input_bucket=os.environ["INPUT_BUCKET"],
            output_bucket=os.environ["OUTPUT_BUCKET"],
            namespace=os.environ["OBJECT_STORAGE_NAMESPACE"],
            threshold=int(os.environ.get("LOW_STOCK_THRESHOLD", "10")),
        )
        return response.Response(ctx, response_data=json.dumps(result),
                                 headers={"Content-Type": "application/json"})
    except Exception as exc:
        log("processing_failed", error_type=type(exc).__name__, error=str(exc))
        raise
