#!/bin/bash

set -e

echo "sign a playbook"

ansible-playbook /etc/playbook-integrity-collection/playbooks/sign-playbook.yml -e repo=/etc/target-repo -e sigtype=sigstore -e key=/etc/cosign.key
mkdir /etc/sigfiles
cp /etc/target-repo/sha256sum* /etc/sigfiles/

echo "signature has benn generated at /etc/sigfiles"