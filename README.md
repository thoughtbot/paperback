# Paperback

*Standardize and streamline eBook production.*

Paperback generates eBooks in many formats from Markdown files. It combines
[Pandoc](http://johnmacfarlane.net/pandoc/index.html) with custom Markdown
extensions to pull in code samples from a bundled example application.

## Installation

1. [Set up Docker](https://docs.docker.com/installation).

1. Build the image.

        $ git clone git@github.com:thoughtbot/paperback.git
        $ cd paperback
        $ docker build --tag thoughtbot/paperback .

## Getting Started

1. Get an overview of available commands.

        $ docker run thoughtbot/paperback help

1. Generate a new book.

        $ mkdir DIRECTORY && cd DIRECTORY
        $ docker run --volume $PWD:/book thoughtbot/paperback new

1. [Push it to GitHub](http://git.io/bxAu).

1. Build all packages and formats or a subset.

        $ docker run --volume $PWD:/book thoughtbot/paperback build
        $ docker run --volume $PWD:/book thoughtbot/paperback build --format pdf --package book

## Formatting

### HTML

You can modify the styling by compiling the Sass.

    $ cd lib/paperback/assets/css
    $ sass --watch application.scss

### Cover

* Dimensions: 6 x 9 inches
* File type: PDF
* Graphics type: Vector (if possible)

## Development

1. Follow [installation](#installation) instructions.

1. Open an interactive Docker shell.

        $ ./bin/docker-shell

1. Edit files as normal on your local host.

1. Run build commands on the container.

        $ bundle install
        $ rake

## Contributing

Please see our [contributing guidelines](CONTRIBUTING.md) for details.
