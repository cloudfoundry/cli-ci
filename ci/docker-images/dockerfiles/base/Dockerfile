FROM golang:1.18.3

RUN go version

# used to ensure we avoid a Git security CVE (https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19604)
RUN apt update && apt upgrade -y

# used by coverage utilities
RUN go install golang.org/x/tools/cmd/cover@latest

# used by go-bindata
RUN go install github.com/shuLhan/go-bindata/...

# used to set the icon when build binaries for windows
RUN go install github.com/akavel/rsrc@latest

RUN sed -i -e 's/httpredir.debian.org/ftp.us.debian.org/' /etc/apt/sources.list

# used in CATs tests, building the binaries, and internationalization
RUN apt update && apt install -y jq zip make vim locales

# install bosh
RUN curl -L https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-5.2.2-linux-amd64 --output /usr/local/bin/bosh && chmod 0755 /usr/local/bin/bosh

# install credhub
RUN curl -L https://github.com/cloudfoundry-incubator/credhub-cli/releases/download/2.0.0/credhub-linux-2.0.0.tgz --output /tmp/credhub.tgz && tar -xzf /tmp/credhub.tgz -C /usr/local/bin && chmod 0755 /usr/local/bin/credhub

# install credhub v1.6.0 for legacy environment
RUN curl -L https://github.com/cloudfoundry-incubator/credhub-cli/releases/download/1.6.0/credhub-linux-1.6.0.tgz --output /tmp/credhub.tgz && tar -xzf /tmp/credhub.tgz && mv credhub /usr/local/bin/credhub1 && chmod 0755 /usr/local/bin/credhub1

# install bbl
RUN curl -L https://github.com/cloudfoundry/bosh-bootloader/releases/download/v8.4.89/bbl-v8.4.89_linux_x86-64 --output /usr/local/bin/bbl && chmod 0755 /usr/local/bin/bbl

# install bbl v5.11.6 for legacy environment
RUN curl -L https://github.com/cloudfoundry/bosh-bootloader/releases/download/v5.11.6/bbl-v5.11.6_linux_x86-64 --output /usr/local/bin/bbl5 && chmod 0755 /usr/local/bin/bbl5
