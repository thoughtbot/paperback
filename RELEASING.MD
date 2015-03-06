# Releasing

1. Create an annotated tag for the new version.

        $ git tag --annotate vX.Y.Z --message 'vX.Y.Z'
        $ git push origin vX.Y.Z

1. Build and save an image.

        $ docker build --no-cache --tag thoughtbot/paperback .
        $ docker save thoughtbot/paperback | gzip --to-stdout > thoughtbot-paperback-X.Y.Z.tar.gz

1. Attach the image to a
   [release](https://help.github.com/articles/creating-releases).
