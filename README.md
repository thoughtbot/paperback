# Paperback

*Standardize and streamline eBook production.*

Paperback generates eBooks in many formats from Markdown files. It combines
[Pandoc](http://johnmacfarlane.net/pandoc/index.html) with custom Markdown
extensions to pull in code samples from a bundled example application.

## Installation

Running Paperback in a container, built with the included Dockerfile, is the
easiest way to ensure Paperback is running with all of its many dependencies,
including fonts.

1. [Set up Podman](https://podman.io/docs/installation).

1. Build the image.

        $ podman build --arch arm64 -t paperback .

> Note: The current Dockerfile is still a work in progress.
> It is set up to work on Apple Silicon systems (arm64).
> It has not yet been tested on Intel macOS or Linux systems.

## Getting Started

1. Get an overview of available commands.

        $ podman run localhost/paperback help

1. Generate a new book.

        $ mkdir DIRECTORY && cd DIRECTORY
        $ podman run --volume $PWD:/src localhost/paperback new

1. [Push it to GitHub](http://git.io/bxAu).

1. Build all packages and formats or a subset.

        $ podman run --volume $PWD:/src localhost/paperback build
        $ podman run --volume $PWD:/src localhost/paperback build --format pdf --package book

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
