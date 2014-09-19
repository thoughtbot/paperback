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

Install Homebrew packages:

    $ brew bundle

Install LaTeX packages:

    sudo tlmgr update --self
    sudo tlmgr install upquote
    sudo tlmgr install cm-super

Install fonts

* [Proxima Nova](https://www.dropbox.com/s/sptt0ii6cdi9w6e/Proxima%20Nova.zip)
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

## AWS S3 Integration

You can release to AWS S3 by setting the appropriate environment variables or
by placing them in a `.env` file. The following variables must be present for
S3 integration:

    AWS_ACCESS_KEY_ID
    AWS_BUCKET
    AWS_SECRET_ACCESS_KEY

## Contributing

Please see our [contributing guidelines](CONTRIBUTING.md) for details.
