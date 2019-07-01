#!/bin/sh
export TF_VAR_AWS_ACCESS_KEY_ID=
export TF_VAR_access_key=
export TF_VAR_VAULT_AWSKMS_SEAL_KEY_ID=
export TF_VAR_kms_key_id=
export TF_VAR_ssh_private_key=`cat ~/.ssh/hashistack.pem`
export TF_VAR_pubkey=
export TF_VAR_secret_key=
export TF_VAR_AWS_SECRET_ACCESS_KEY=
export TF_VAR_consul_instance_type="t2.micro"
export TF_VAR_vault_instance_type="t2.micro"
export TF_VAR_ha_flag="false"
export TF_VAR_vault_instance_count_ha=3
export TF_VAR_consul_instance_count_ha=3
export TF_VAR_vault_fqdn="vault.kabuctl.run"
export TF_VAR_consul_fqdn="consul.kabuctl.run"
