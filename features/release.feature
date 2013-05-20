Feature: Release
  As a user
  I want a CLI to release my Paperback project
  So that I can promote the current build

  Scenario:
    When I successfully run `paperback new .`
    And I create a git repo named "a-nice-adventure"
    And I successfully run `paperback release`
    Then the following files should exist:
      | release/a-nice-adventure.epub        |
      | release/a-nice-adventure.html        |
      | release/a-nice-adventure.mobi        |
      | release/a-nice-adventure.pdf         |
      | release/images/cover.pdf             |
      | release/images/cover.png             |
      | release/a-nice-adventure-sample.epub |
      | release/a-nice-adventure-sample.html |
      | release/a-nice-adventure-sample.mobi |
      | release/a-nice-adventure-sample.pdf  |
    And the following files should exist on S3:
      | a-nice-adventure.epub                |
      | a-nice-adventure.html                |
      | a-nice-adventure.mobi                |
      | a-nice-adventure.pdf                 |
      | images/cover.pdf                     |
      | images/cover.png                     |
      | a-nice-adventure-sample.epub         |
      | a-nice-adventure-sample.html         |
      | a-nice-adventure-sample.mobi         |
      | a-nice-adventure-sample.pdf          |
