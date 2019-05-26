#!/bin/sh

cat << EOF > vault-config-template.hcl

listener "tcp" {
  address     = VAULT_ADDR
  tls_disable = 1
}

api_addr = VAULT_ADDR

ui = true

EOF