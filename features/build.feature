Feature: Build
  As a user
  I want a CLI to build my Paperback project
  So that I can generate a book in multiple formats

  Scenario: The input is invalid
    When I successfully run `paperback new .`
    And a file named "book/book.md" with:
      """
      \foo
      """
    When I run `paperback build`
    Then it should fail with:
      """
      pandoc: Error
      """

  Scenario: The input is valid
    When I successfully run `paperback new .`
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
      <<[samples.md]
      """
    And a file named "book/chapters.md" with:
      """
      # Chapter One

      ## Subheading

      ### Subsubheading
          ` foo.rb@HEAD
      ` UnknownFileType@HEAD
      ` foo.coffee@HEAD
      ` index.html.erb@HEAD

      # Chapter Two

      STUB
      """
    And a file named "book/samples.md" with:
      """
      # Chapter Three
      ![Alt text](images/image.png)
      """
    And a file named "example_app/foo.rb" with:
      """
      foo.bar
      """
    And an empty file named "example_app/UnknownFileType"
    And an empty file named "example_app/foo.coffee"
    And an empty file named "example_app/index.html.erb"
    And a fixture file named "book/images/image.png"
    And I create a git repo named "a-book"
    When I successfully run `paperback build`
    Then the output should contain "create  a-book.md"
    And the file "build/a-book/a-book.md" should contain:
      """
      % Book
      # Introduction
      \part{Part One}
      # Chapter One

      ## Subheading

      ### Subsubheading
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
    And the TOC from "build/a-book/a-book.html" should reference "subheading"
    But the TOC from "build/a-book/a-book.html" should not reference "subsubheading"
    And the file "build/a-book/a-book.toc.html" should contain:
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
    And the file "build/a-book/a-book-sample.md" should contain:
      """
      % Sample
      # Chapter Three
      """
    And the following files should exist:
      | build/a-book/a-book.epub        |
      | build/a-book/a-book.html        |
      | build/a-book/a-book.mobi        |
      | build/a-book/a-book.pdf         |
      | build/a-book/images/cover.pdf   |
      | build/a-book/images/cover.png   |
      | build/a-book/a-book-sample.epub |
      | build/a-book/a-book-sample.html |
      | build/a-book/a-book-sample.mobi |
      | build/a-book/a-book-sample.pdf  |
    And "build/a-book/a-book.pdf" should have page sizes for a book
    And "build/a-book/a-book.pdf" should embed appropriate screen fonts
