import json
def generate_manifest(
    labels: list,
    dataset_bucket: str,
    dataset_namespace: str,
    record_bucket: str,
    record_namespace: str,
    record_path: str,
    output_path: str = "manifest.jsonl",
    prefix: str = ""
):
    """
    Generate a .jsonl file with a specified structure.
    Parameters:
    - labels: list of label names (e.g., ["Invoice_date", "Invoice_Number"])
    - dataset_bucket: bucket name for dataset source
    - dataset_namespace: namespace for dataset source
    - record_bucket: bucket name for record file
    - record_namespace: namespace for record file
    - record_path: path to record file (e.g., "records_image_ls.json")
    - output_path: path to save .jsonl file
    """
    json_obj = {
        "id": "dummy",
        "compartmentId": "dummy",
        "displayName": "training_data",
        "labelsSet": [{"name": label} for label in labels],
        "annotationFormat": "KEY_VALUE",
        "datasetSourceDetails": {
            "namespace": dataset_namespace,
            "bucket": dataset_bucket,
            "prefix": prefix
        },
        "datasetFormatDetails": {
            "formatType": "DOCUMENT"
        },
        "recordFiles": [
            {
                "namespace": record_namespace,
                "bucket": record_bucket,
                "path": record_path
            }
        ]
    }
    with open(output_path, "w") as f:
        f.write(json.dumps(json_obj) + "\n")
    print(f"JSONL file written to {output_path}")
## Test Example
labels = ["Invoice_Number", "Date", "Due_Date", "Supplier_Address", "Client_Address",
          "VAT_Number","SubTotal", "Tax","Total","Bank_Name","IBAN","SWIFT"]  # Be careful, it's case sensitive
generate_manifest(
    labels=labels,
    dataset_bucket="raushan_bucket",
    dataset_namespace="axylfvgphoea",
    record_bucket="raushan_bucket",
    record_namespace="axylfvgphoea",
    record_path="test_ls_integration/records_converted_kv.json",
    output_path="manifest.jsonl", # extension should be .jsonl 
    prefix="test_ls_integration/" #prefix always ends with /
)