# Paperback

Standardize and streamline ebook production.

Paperback makes it easy to generate ebooks in many formats (pdf, html, epub and
mobi) from Markdown files.

It combines [Pandoc](http://johnmacfarlane.net/pandoc/index.html) with some
custom Markdown extensions which make it easy to pull in code samples from a
bundled example application.

## Installation

Add this line to your application's Gemfile:

    gem 'paperback'

And then execute:

    $ bundle
    $ bundle binstubs paperback

Or install it yourself as:

    $ gem install paperback

## Dependencies

Install Homebrew packages:

    $ brew install gs
    $ brew install hub
    $ brew install imagemagick
    $ brew tap phinze/homebrew-cask
    $ brew install brew-cask
    $ brew cask install basictex
    $ brew cask install pandoc

Install LaTeX packages:

    sudo tlmgr update --self
    sudo tlmgr install upquote
    sudo tlmgr install cm-super

Install fonts (Proxima Nova and Inconsolata):

    https://www.dropbox.com/sh/ntxu99zcm28agp8/Cqiwu9ORA5
    http://www.levien.com/type/myfonts/inconsolata.html

## Usage

See help:

    $ paperback

## Formatting

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
    AWS_SECRET_KEY_ID

## Contributing

Please see `CONTRIBUTING.md` for more details on contributing.
