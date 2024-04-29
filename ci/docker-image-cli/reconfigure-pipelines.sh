#!/usr/bin/env bash

set -e
set -o pipefail
cli_version=$1
cli_branch=$2

check_installed() {
  if ! command -v $1 > /dev/null 2>&1; then
    printf "$1 must be installed before running this script!"
    exit 1
  fi
}

configure_pipeline() {
  local name=$1
  local pipeline=$2

  printf "configuring the $name pipeline...\n\n"
  printf "*********************************************************\n"
  printf "NOTE: Please make sure you are logged into vault...\n"
  printf "*********************************************************\n"

  printf "configuring the $name pipeline...\n"

  export VAULT_ADDR=https://tpe-vault-rock.eng.vmware.com
    fly -t ci set-pipeline \
    -p $name \
    -c $pipeline \
    -v dockerhub-username="$(vault kv get -mount='secret_devex' -field='cff-dockerhub-username' 'cli')" \
    -v dockerhub-password="$(vault kv get -mount='secret_devex' -field='cff-dockerhub-password' 'cli')" \
    --var="cli-version=$cli_version" \
    --var="cli-branch=$cli_branch" \
    --var="cli-current-major=8"
}
check_installed vault
check_installed fly

configure_pipeline cf-cli-v$1-docker-image pipeline.yml
