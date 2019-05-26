#!/bin/sh

cat << EOF > vault-config-template.hcl

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = 1
}

ui = true

EOF