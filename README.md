# Bitbucket build status update

Sends a status update to a bitbucket server via the REST API

## How to use this Step

add the BITBUCKET_STATUS_URL and SECRET_BITBUCKET_AUTH to your Env Vars/Secrets.

```
envs:
- BITBUCKET_STATUS_URL: url to the bitbucket server e.g. https://git.yourfancyserver.com/rest/build-status/1.0/commits
- SECRET_BITBUCKET_AUTH: auth for bitbucket server like: username:password
```

Add the step to your yaml file:

```yml
# ...
workflows:
  TestAndLint:
    steps:
      - activate-ssh-key@4.0.3:
          run_if: '{{getenv "SSH_RSA_PRIVATE_KEY" | ne ""}}'
      - git-clone@4.0.13: {}
      - git::https://github.com/berichte/bitbucket-build-status-update.git:
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
