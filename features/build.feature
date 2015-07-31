Feature: Build
  As a user
  I want a CLI to build my Paperback project
  So that I can generate a book in multiple formats

  Background:
    Given I successfully run `paperback new`
    And a file named "book/book.md" with:
      """
      % Book

      # Introduction

      \part{Part One}

      <<[chapters.md]
      """
    And a file named "book/sample.md" with:
      """
      % Sample

      <<[sample/introduction.md]
      """
    And a file named "book/chapters.md" with:
      """
      # Chapter One
      ## Subheading
          ` foo.rb@HEAD
      ` UnknownFileType@HEAD
      ` foo.coffee@HEAD
      ` index.html.erb@HEAD

      # Chapter Two

      STUB
      """
    And a file named "book/sample/introduction.md" with:
      """
      # Chapter Three
      ![Alt text](../images/image.png)
      """
    And a file named "example_app/foo.rb" with:
      """
      foo.bar
      """
    And an empty file named "example_app/UnknownFileType"
    And an empty file named "example_app/foo.coffee"
    And an empty file named "example_app/index.html.erb"
    And a fixture file named "book/images/image.png"
    And I create a git repo named "a-nice-adventure"

  Scenario: Invalid input
    Given a file named "book/book.md" with:
      """
      \foo
      """
    When I run `paperback build`
    Then it should fail with:
      """
      pandoc: Error
      """

  Scenario: All packages
    Given I successfully run `paperback build`
    Then the file "build/a-nice-adventure/a-nice-adventure.md" should contain:
      """
      % Book

      # Introduction

      \part{Part One}

      # Chapter One
      ## Subheading
          ```ruby
          # foo.rb
          foo.bar
          ```
      ```
      # UnknownFileType

      ```
      ```coffee
      # foo.coffee

      ```
      ```rhtml
      # index.html.erb

      ```

      # Chapter Two

      STUB
      """
    And the file "build/a-nice-adventure/a-nice-adventure.toc.html" should contain:
      """
      <section id="table-of-contents">
        <h3>Table of Contents</h3>
        <ul>
          <li>Introduction</li>
          <li>
            <h3>Part One</h3>
            <ul>
              <li>Chapter One</li>
              <li>Chapter Two*</li>
            </ul>
          </li>
        </ul>
      </section>
      """
    And the file "build/a-nice-adventure/a-nice-adventure-sample.md" should contain:
      """
      % Sample

      # Chapter Three
      ![Alt text](images/image.png)
      """
    And the following files should exist:
      | build/a-nice-adventure/a-nice-adventure-sample.epub |
      | build/a-nice-adventure/a-nice-adventure-sample.html |
      | build/a-nice-adventure/a-nice-adventure-sample.mobi |
      | build/a-nice-adventure/a-nice-adventure-sample.pdf  |
      | build/a-nice-adventure/a-nice-adventure.epub        |
      | build/a-nice-adventure/a-nice-adventure.html        |
      | build/a-nice-adventure/a-nice-adventure.mobi        |
      | build/a-nice-adventure/a-nice-adventure.pdf         |
      | build/a-nice-adventure/images/cover.pdf             |
      | build/a-nice-adventure/images/cover.png             |
    And "build/a-nice-adventure/a-nice-adventure.pdf" should have page sizes for a book
    And "build/a-nice-adventure/a-nice-adventure.pdf" should embed appropriate screen fonts

  Scenario: A single package
    When I successfully run `paperback build --package=book`
    Then the following files should exist:
      | build/a-nice-adventure/a-nice-adventure.epub        |
      | build/a-nice-adventure/a-nice-adventure.html        |
      | build/a-nice-adventure/a-nice-adventure.mobi        |
      | build/a-nice-adventure/a-nice-adventure.pdf         |
    And the following files should not exist:
      | build/a-nice-adventure/a-nice-adventure-sample.epub |
      | build/a-nice-adventure/a-nice-adventure-sample.html |
      | build/a-nice-adventure/a-nice-adventure-sample.mobi |
      | build/a-nice-adventure/a-nice-adventure-sample.pdf  |

  Scenario: A single format
    When I successfully run `paperback build --format=html`
    Then the following files should exist:
      | build/a-nice-adventure/a-nice-adventure-sample.html |
      | build/a-nice-adventure/a-nice-adventure.html        |
    And the following files should not exist:
      | build/a-nice-adventure/a-nice-adventure-sample.epub |
      | build/a-nice-adventure/a-nice-adventure-sample.mobi |
      | build/a-nice-adventure/a-nice-adventure-sample.pdf  |
      | build/a-nice-adventure/a-nice-adventure.epub        |
      | build/a-nice-adventure/a-nice-adventure.mobi        |
      | build/a-nice-adventure/a-nice-adventure.pdf         |

  Scenario: Successive runs
    When I successfully run `paperback build`
    And I successfully run `cp -r build/ public/`
    And I successfully run `paperback build`
    Then I successfully run `diff --recursive build/a-nice-adventure/images/ public/a-nice-adventure/images/`
