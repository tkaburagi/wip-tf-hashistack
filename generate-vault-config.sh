#!/bin/sh

cat << EOF > vault-config.hcl

listener "tcp" {
  address     = VAULT_ADDR
  tls_disable = 1
}

api_addr = VAULT_CLUSTER_ADDR

ui = true

EOF