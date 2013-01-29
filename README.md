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

Or install it yourself as:

    $ gem install paperback

## Dependencies

Install Pandoc:

    http://johnmacfarlane.net/pandoc/installing.html

Install BasicTeX:

    http://www.tug.org/mactex/morepackages.html

Install Homebrew packages:

    $ brew install gs
    $ brew install imagemagick

## Usage

See help:

    $ paperback

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
