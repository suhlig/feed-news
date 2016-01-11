# Feed News

This is a simple Ruby application that prints the title of the latest entry of a feed if that entry hasn't been seen by this application before. The state is kept in a local file.

This is useful to follow github releases like [BOSH](https://github.com/cloudfoundry/bosh/) or
[CloudFoundry](https://github.com/cloudfoundry/cf-release/) in a CI pipeline.

The [GitHub Releases Resource](https://github.com/concourse/github-release-resource) performs similar tasks in a [Concourse](https://concourse.ci) pipeline.
