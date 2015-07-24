# Contributing

We love pull requests. Please follow our [Git protocol][git] and
[style guides][style].

By participating in this project, you agree to abide by
the thoughtbot [code of conduct].

[code of conduct]: https://thoughtbot.com/open-source-code-of-conduct
[git]: https://github.com/thoughtbot/guides/tree/master/protocol/git
[style]: https://github.com/thoughtbot/guides/tree/master/style

## Developing

1. Follow [installation](README.md#installation) instructions.

1. Open an interactive Docker shell.

        $ bin/docker-shell

1. Edit files as normal on your local host.

1. Run build commands on the container.

        $ bundle install
        $ rake

1. You can also run arbitrary commands like `rake` with `bin/docker-run`:

        $ ./bin/docker-run rake

## Releasing

Please see our [releasing guidelines](RELEASING.md) for details.
