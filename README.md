# Paperback

*Standardize and streamline eBook production.*

Paperback generates eBooks in many formats from Markdown files. It combines
[Pandoc](http://johnmacfarlane.net/pandoc/index.html) with custom Markdown
extensions to pull in code samples from a bundled example application.

## Installation

1. [Setup Docker](https://docs.docker.com/installation).

1. Build the image.

        $ git clone git@github.com:thoughtbot/paperback.git
        $ cd paperback
        $ docker build -t thoughtbot/paperback .

## Getting Started

1. Get an overview of available commands.

        $ docker run thoughtbot/paperback help

1. Generate a new book.

        $ mkdir DIRECTORY && cd DIRECTORY
        $ docker run -v $PWD:/source thoughtbot/paperback new

1. [Push it to GitHub](http://git.io/bxAu).

1. Build all packages and formats.

        $ docker run -v $PWD:/source thoughtbot/paperback build

## Formatting

### HTML

You can modify the styling by compiling the Sass.

    $ cd lib/paperback/assets/css
    $ sass --watch application.scss

### Cover

* Dimensions: 6 x 9 inches
* File type: PDF
* Graphics type: Vector (if possible)

## Contributing

Please see our [contributing guidelines](CONTRIBUTING.md) for details.
