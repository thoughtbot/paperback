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

Install fonts (Proxima Nova, and Inconsolata):

    https://www.dropbox.com/sh/ntxu99zcm28agp8/Cqiwu9ORA5
    http://www.levien.com/type/myfonts/inconsolata.html

Install the LaTeX packages:

    sudo tlmgr update --self
    sudo tlmgr install upquote
    sudo tlmgr install cm-super

You may need to add its bin directory to your PATH:

    export PATH=$PATH:/usr/texbin

## Usage

See help:

    $ paperback

## Contributing

If you'd like to contribute a feature or bugfix: Thanks! To make sure your
fix/feature has a high chance of being included, please read the following
guidelines:

Please see `CONTRIBUTING.md` for more details on contributing.

## Credits

![thoughtbot](http://thoughtbot.com/images/tm/logo.png)

Paperback is maintained by [thoughtbot, inc](http://thoughtbot.com/community)
and [contributors](/thoughtbot/clearance/contributors) like you. Thank you!

## License

Paperback is copyright © 2012-2013 thoughtbot. It is free software, and may be
redistributed under the terms specified in the `LICENSE` file.

The names and logos for thoughtbot are trademarks of thoughtbot, inc.
