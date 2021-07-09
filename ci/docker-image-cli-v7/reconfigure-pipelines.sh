#!/usr/bin/env bash

set -e
set -o pipefail

check_installed() {
  if ! command -v $1 > /dev/null 2>&1; then
    printf "$1 must be installed before running this script!"
    exit 1
  fi
}

configure_pipeline() {
  local name=$1
  local pipeline=$2

  printf "configuring the $name pipeline...\n"

  fly -t runway set-pipeline \
    -p $name \
    -c $pipeline \
    -l <(lpass show 'Shared-CLI/Release Process/release-pipeline-concourse-credentials.yml' --notes) \
    --var="sc2-client-id=$(lpass show 'Shared-frontend/SC2 PCF1 Service Account svc.ui-sustainers' --username)" \
    --var="sc2-client-secret=$(lpass show 'Shared-frontend/SC2 PCF1 Service Account svc.ui-sustainers' --password)"
}

check_installed lpass
check_installed fly

# Make sure we're up to date and that we're logged in.
lpass sync

pipelines_path=$(cd $(dirname $0)/.. && pwd)

configure_pipeline claw $pipelines_path/claw-pipeline.yml
