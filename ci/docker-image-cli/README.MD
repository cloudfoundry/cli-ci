# Pipeline for building and publishing CF-CLI docker image into dockerhub

Inside this folder you would find the definition of the cli docker image creation and publishing pipeline
as well as the script for reflying it.

### Reflying/Flying the pipeline
If you want to fly the pipeline for any of the versions available, please follow these steps:

```
1. Make sure you have the cli branch name and cli major version
2. Log into last pass using lpass login <youremail@vmware.com>
3. Run the script ./reconfigure-pipelines.sh passing the following args in this order: cli_version, cli_branch

The command should look something like this: ./reconfigure-pipelines.sh 7 v7
```

