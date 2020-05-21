This repository is the location of the CloudFoundry (CF) CLI CI Configuration.

Inside are files describing our CI pipelines.

This used to live inside of the CF CLI main repo, so the history might be
limited.

We removed it from the main repository here -> https://github.com/cloudfoundry/cli/commit/3560caa1855c94f54635826465712fc174b03fd2

Inspect the ci folder in the main repo before this commit to see history before
May 21st, 2020



# CLI Concourse

## Setup MacOS Concourse worker

- Copy `./com.pivotal.ConcourseWorker.plist` to `/Library/LaunchDaemons`
- Copy `./bin/concourse_worker` to `/Users/pivotal/bin/concourse_worker`
- Load service `sudo launchctl load -w /Library/LaunchDaemons/com.pivotal.ConcourseWorker.plist`
- Start service `launchctl start com.pivotal.ConcourseWorker`
- Check system logs using `lnav`
- Check worker logs `sudo tail -f /usr/local/var/log/concourse-worker.std*.log`
