"""Offline check of the exact extracted Linux archive, with synthetic credentials."""
import os
import time
from unittest.mock import patch

import jwt
import oci
from cryptography.hazmat.primitives import serialization
from cryptography.hazmat.primitives.asymmetric import rsa
from oci._vendor import requests

key = rsa.generate_private_key(public_exponent=65537, key_size=2048)
pem = key.private_bytes(serialization.Encoding.PEM, serialization.PrivateFormat.PKCS8,
                        serialization.NoEncryption()).decode()
token = jwt.encode({"exp": int(time.time()) + 3600, "res_tenant": "synthetic-test"}, key, algorithm="RS256")
with patch.dict(os.environ, {
    "OCI_RESOURCE_PRINCIPAL_VERSION": "2.2",
    "OCI_RESOURCE_PRINCIPAL_RPST": token,
    "OCI_RESOURCE_PRINCIPAL_PRIVATE_PEM": pem,
    "OCI_RESOURCE_PRINCIPAL_REGION": "us-chicago-1",
}):
    signer = oci.auth.signers.get_resource_principals_signer()
    client = oci.object_storage.ObjectStorageClient(config={}, signer=signer,
                  retry_strategy=oci.retry.DEFAULT_RETRY_STRATEGY)
    assert callable(client.get_object) and callable(client.put_object)
    request = requests.Request("PUT", "https://objectstorage.us-chicago-1.oraclecloud.com/n/test/b/test/o/test.csv",
                               data=b"record_id,quantity\nTEST,5\n").prepare()
    signer(request)
    assert request.headers["Authorization"].startswith("Signature ")
    assert "x-content-sha256" in request.headers
print(f"PASS packaged Linux SDK {oci.__version__}: imports, resource-principal signer, Object Storage client, signed PUT.", flush=True)
