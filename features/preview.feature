Feature: Preview
  As a user
  I want a CLI to preview my Paperback project
  So that I can quickly view a book in PDF format

  Scenario:
    When I successfully run `paperback new .`
    And I create a git repo named "a-nice-adventure"
    And I double `open`
    And I successfully run `paperback preview`
    Then the following files should exist:
      | build/a-nice-adventure.pdf |
      | build/images/cover.pdf     |
    And the following files should not exist:
      | build/a-nice-adventure.epub        |
      | build/a-nice-adventure.html        |
      | build/a-nice-adventure.mobi        |
      | build/images/cover.png             |
      | build/a-nice-adventure-sample.epub |
      | build/a-nice-adventure-sample.html |
      | build/a-nice-adventure-sample.mobi |
      | build/a-nice-adventure-sample.pdf  |
