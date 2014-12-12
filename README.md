# Paperback

Standardize and streamline ebook production.

Paperback makes it easy to generate ebooks in many formats (pdf, html, epub and
mobi) from Markdown files.

It combines [Pandoc](http://johnmacfarlane.net/pandoc/index.html) with some
custom Markdown extensions which make it easy to pull in code samples from a
bundled example application.

## Installation

Add this line to your application's Gemfile:

    gem "paperback"

And then execute:

    $ bundle
    $ bundle binstubs paperback

Or install it yourself as:

    $ gem install paperback

## Dependencies

This repository comes equipped with a self-setup script:

    $ ./bin/setup

Install fonts

* [Open Sans](https://www.google.com/fonts/specimen/Open+Sans)
* [Inconsolata](http://www.levien.com/type/myfonts/inconsolata.html)

## Usage

See help:

    $ paperback

## Formatting

You can modify the styling by compiling the Sass:

    $ cd lib/paperback/assets/css
    $ sass --watch application.scss

### Cover

* Dimensions: 6 x 9 inches
* File type: PDF
* Graphics type: Vector (if possible)

## Contributing

Please see our [contributing guidelines](CONTRIBUTING.md) for details.
