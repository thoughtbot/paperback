# Paperback

Standardize and streamline ebook production.

Paperback makes it easy to generate ebooks in many formats (pdf, html, epub and
mobi) from Markdown files.

It combines [Pandoc](http://johnmacfarlane.net/pandoc/index.html) with some
custom Markdown extensions which make it easy to pull in code samples from a
bundled example application.

## Dependencies

This repository comes equipped with a self-setup script:

    $ ./bin/setup

Install fonts

* [Open Sans](https://www.google.com/fonts/specimen/Open+Sans)
* [Inconsolata](http://www.levien.com/type/myfonts/inconsolata.html)

## Getting Started

As it is not a public gem, you will need to install it via Bundler and
reference the repo directly.

These instructions will get you started with a new book called **my-awesome-book** from scratch.

Paperback requires a Git respository and a remote named `origin` for the book name.
So, it is best to use the name of your book as the repository. Create your
repository on GitHub.com in the thoughtbot organization, and add it as a remote.

    $ mkdir my-awesome-book
    $ cd my-awesome-book
    $ git init
    $ git remote add origin git@github.com:thoughtbot/my-awesome-book.git

Create a new folder for the book project and create a Gemfile

    $ touch Gemfile

Add the following into your Gemfile:

```
source 'https://rubygems.org'

gem 'paperback', git: 'git@github.com:thoughtbot/paperback.git'
```

And then bundle and initialize a new paperback book:
    $ bundle
    $ bundle exec paperback new .

Stage your files, make your first commit and push:

    $ git add .
    $ git commit -m "Set up Paperback to build the book"
    $ git push -u origin master

Now edit the contents of the book in the `./book` folder, and build the book!

    $ bundle exec paperback build

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
