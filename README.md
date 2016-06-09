# Paperback

*Standardize and streamline eBook production.*

Paperback generates eBooks in many formats from Markdown files. It combines
[Pandoc](http://johnmacfarlane.net/pandoc/index.html) with custom Markdown
extensions to pull in code samples from a bundled example application.

## Installation

1. [Set up Docker](https://docs.docker.com/engine/installation/).

1. Join the thoughtbot [organization] on Docker Hub.

1. Pull the [latest image].

        $ docker pull thoughtbot/paperback

## Getting Started

1. Get an overview of available commands.

        $ docker run thoughtbot/paperback help

1. Generate a new book.

        $ mkdir DIRECTORY && cd DIRECTORY
        $ docker run --volume $PWD:/src thoughtbot/paperback new

1. [Push it to GitHub](http://git.io/bxAu).

1. Build all packages and formats or a subset.

        $ docker run --volume $PWD:/src thoughtbot/paperback build
        $ docker run --volume $PWD:/src thoughtbot/paperback build --format pdf --package book

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

For information about local development,
see the [contributing guidelines](CONTRIBUTING.md).

[latest image]: https://hub.docker.com/r/thoughtbot/paperback/
[organization]: https://hub.docker.com/u/thoughtbot/
