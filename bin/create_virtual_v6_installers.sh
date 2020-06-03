#!/usr/bin/env bash

set -eu

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
CF6_TEMPLATE="$DIR/../ci/installers/rpm/cf6-cli.spec.template"

log() {
  echo "==> $1"
}

create_installer() {
  arch="$1"
  template="$2"
  version="$3"

  log "$version: Creating $arch installer at $template..."

  echo "Version: $version" > $template
  echo "Requires: cf-cli = $version" >> $template
  cat $CF6_TEMPLATE >> $template
  rpmbuild --define "_rpmdir $dir" --target $arch -bb $template
  sign_installer $dir/$arch/*
  mv $dir/$arch/* $dir
  rm -rf "$dir/$arch"
}

create_installers_for_version_dir() {
  dir=$1
  version="$(echo $1 | tr -d v)"
  template_dir="$2"
  installer_template="$template_dir/cf6-$version.rpm.template"

  for file in $dir/*.rpm; do
    if [[ ! -f $file ]]; then
      log "$version: Skipping because it had no existing rpm files..."
      return
    fi
    break
  done

  create_installer "i386" "$installer_template" "$version"
  create_installer "x86_64" "$installer_template" "$version"
}

sign_installer() {
  installer_path="$1"

  # workaround for phusion base image; which prompts for a pass phrase
  cat<<EOF >sign-rpm
#!/usr/bin/expect -f
spawn rpmsign --addsign {*}\$argv
expect -exact "Enter pass phrase: "
send -- "\r"
expect eof
EOF
  chmod 700 sign-rpm

  ./sign-rpm $installer_path

  # log "Signing $installer_path..."
  # rpmsign --addsign $installer_path

  rm -f sign-rpm
}

init_gpg() {
  gpg_dir=$1
  gpg_key_location=$2

  export GNUPGHOME=$gpg_dir
  chmod 700 $GNUPGHOME

  gpg --import $gpg_key_location

  cat<< EOF >~/.rpmmacros
%_gpg_name CF CLI Team <cf-cli-eng@pivotal.io>
EOF
}

main() {
  # Test usage: create_virtual_v6_installers.sh "s3://cf-cli-dev/releases" "/tmp/gpg_dir/privatekey.asc"
  # Prod usage:
  # > sudo docker run -v ~/workspace/cli-ci:/tmp/cli-ci -v /Volumes/certificates/:/tmp/certificates -it cfcli/cli-package /bin/bash
  # > cd /tmp/cli-ci
  # > aws configure # enter the Administrator credentials
  # > bin/create_virtual_v6_installers.sh "s3://cf-cli-releases/releases/" "/tmp/certificates/Cloudfoundry-Private-PGP.gpg"
  # > aws s3 sync $release_dir s3://cf-cli-releases/releases # should upload all cf6 rpms
  # > createrepo -s sha $release_dir # creates a repodata folder
  # > aws sync $release_dir/repodata s3://cf-cli-rpm-repo/repodata

  s3_bucket_path=$1
  gpg_key_location=$2
  release_dir="$(mktemp -d)"
  template_dir="$(mktemp -d)"
  gpg_dir="$(mktemp -d)"

  trap "rm -rf $gpg_dir" 0

  log "Release path: $release_dir"
  log "Template path: $template_dir"
  log "GPG path: $gpg_dir"

  aws s3 sync $s3_bucket_path $release_dir

  cd $release_dir

  init_gpg $gpg_dir $gpg_key_location

  for d in *v6* ; do
    create_installers_for_version_dir $d $template_dir
    echo
  done
}

main "$@"
