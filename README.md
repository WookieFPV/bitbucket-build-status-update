# Bitbucket build status update

Sends a status update to a BitBucket server via the REST API

Further information: https://developer.atlassian.com/server/bitbucket/how-tos/updating-build-status-for-commits/

## How to use this Step

Add your BitBucket authentication as a secret variable with the recommended key SECRET_BITBUCKET_AUTH.  
We recommend to add BitBucket server url as env variable with the key BITBUCKET_STATUS_URL.

```
secret variable:
- SECRET_BITBUCKET_AUTH: auth for bitbucket server like: username:password

env variable:
- BITBUCKET_STATUS_URL: url to the bitbucket server e.g. https://git.yourbitbucketserver.com/rest/build-status/1.0/commits
```

We recommend to add this step at the very beginning of your workflow and set the status to INPROGRESS.  
At the very end of your workflow you can add this step with the status AUTO. AUTO will set SUCCESSFUL or FAILED depending on BITRISE_BUILD_STATUS.

As default values for **name** GIT_CLONE_COMMIT_AUTHOR_NAME and for **description** GIT_CLONE_COMMIT_MESSAGE_BODY is used. As key the default "BITRISE" is used.

Debug logs for step can be enabled by setting is_debug_mode to "yes".

Add the step to your yaml file:

```yml
# ...
workflows:
  Checkout:
    steps:
      - git::https://github.com/WookieFPV/bitbucket-build-status-update.git:
# ...
```

## Share your own Step

You can share your Step or step version with the [bitrise CLI](https://github.com/bitrise-io/bitrise). If you use the `bitrise.yml` included in this repository, all you have to do is:

1. In your Terminal / Command Line `cd` into this directory (where the `bitrise.yml` of the step is located)
2. Run: `bitrise run test` to test the step
3. Run: `bitrise run audit-this-step` to audit the `step.yml`
4. Check the `share-this-step` workflow in the `bitrise.yml`, and fill out the
   `envs` if you haven't done so already (don't forget to bump the version number if this is an update
   of your step!)
5. Then run: `bitrise run share-this-step` to share the step (version) you specified in the `envs`
6. Send the Pull Request, as described in the logs of `bitrise run share-this-step`

That's all ;)
