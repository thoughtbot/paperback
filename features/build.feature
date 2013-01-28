Feature: Build
  As a user
  I want a CLI to build my Paperback project
  So that I can generate a book in multiple formats

  Scenario:
    When I successfully run `paperback new .`
    And a file named "book/book.md" with:
      """
      % Book
      <<[one.md]
      """
    And a file named "book/sample.md" with:
      """
      % Sample
      <<[two.md]
      """
    And a file named "book/one.md" with:
      """
      One
      <<(code.erb)
      """
    And a file named "book/two.md" with:
      """
      Two
      """
    And a file named "book/code.erb" with:
      """
      ` foo.rb@a1b2c3
      """
    And I fake git `show a1b2c3:example_app/foo.rb` with:
      """
      foo.bar
      """
    When I successfully run `paperback build`
    Then the file "build/book.md" should contain:
      """
      % Book
      One
      ```rhtml
      # code.erb
      ```ruby
      # foo.rb
      foo.bar
      ```
      ```
      """
    And the file "build/sample.md" should contain:
      """
      % Sample
      Two
      """
    And the following files should exist:
      | build/book.epub        |
      | build/book.html        |
      | build/book.mobi        |
      | build/book.pdf         |
      | build/images/cover.pdf |
      | build/images/cover.png |
      | build/sample.epub      |
      | build/sample.html      |
      | build/sample.mobi      |
      | build/sample.pdf       |
