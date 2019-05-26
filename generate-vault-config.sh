#!/bin/sh

cat << EOF > vault-config-template.hcl

storage "file" {
   path = "/home/ubuntu/localdata"
}

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = 1
}

ui = true

disable_mlock = true

EOF