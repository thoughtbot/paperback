# Releasing

1. Create an annotated tag for the new version.

        $ git tag --annotate vX.Y.Z --message 'vX.Y.Z'
        $ git push origin vX.Y.Z

1. Confirm that the [automated] Docker Hub [builds] were successful.

[automated]: https://docs.docker.com/docker-hub/builds/
[builds]: https://hub.docker.com/r/thoughtbot/paperback/builds/
