FROM quay.io/ansible/ansible-runner:latest

COPY keys/cosignkey /tmp/b64_cosignkey
COPY keys/cosignpub /tmp/b64_cosignpub
COPY sign.sh /etc/sign.sh

RUN cd /etc && \
      cat /tmp/b64_cosignkey | base64 -d > /etc/cosign.key && \
      cat /tmp/b64_cosignpub | base64 -d > /etc/cosign.pub && \
      chmod 0600 /etc/cosign.key && \
      git clone https://github.com/hirokuni-kitahara/ansible-playbook-os-hardening.git && \
      mv /etc/ansible-playbook-os-hardening /etc/target-repo && \
      git clone https://github.com/IBM/playbook-integrity-collection.git && \
      ansible-galaxy collection install git+https://github.com/IBM/playbook-integrity-collection.git

ENTRYPOINT ["/etc/sign.sh"]