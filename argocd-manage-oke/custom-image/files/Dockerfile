FROM quay.io/argoproj/argocd:v3.1.1

USER root


RUN apt-get update; \
    apt-get install -y --no-install-recommends python3-venv; \
    python3 -m venv /opt/oci; \
    /opt/oci/bin/pip install --no-cache-dir --upgrade pip; \
    /opt/oci/bin/pip install --no-cache-dir "oci-cli==3.65.0"; \
    ln -s /opt/oci/bin/oci /usr/local/bin/oci; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/*


USER 999
