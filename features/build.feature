Feature: Build
  As a user
  I want a CLI to build my Paperback project
  So that I can generate a book in multiple formats

  Scenario: Without any options
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
    And I set my origin URL to `git@github.com:thoughtbot/a-nice-adventure.git`
    When I successfully run `paperback build`
    Then the file "build/a-nice-adventure.md" should contain:
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
    And the file "build/a-nice-adventure-sample.md" should contain:
      """
      % Sample
      Two
      """
    And the following files should exist:
      | build/a-nice-adventure.epub        |
      | build/a-nice-adventure.html        |
      | build/a-nice-adventure.mobi        |
      | build/a-nice-adventure.pdf         |
      | build/images/cover.pdf             |
      | build/images/cover.png             |
      | build/a-nice-adventure-sample.epub |
      | build/a-nice-adventure-sample.html |
      | build/a-nice-adventure-sample.mobi |
      | build/a-nice-adventure-sample.pdf  |

  Scenario: With the preview option
    When I successfully run `paperback new .`
    And I set my origin URL to `git@github.com:thoughtbot/a-nice-adventure.git`
    And I double `open`
    And I run `paperback build --preview`
    Then the exit status should be 0
