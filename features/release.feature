Feature: Release
  As a user
  I want a CLI to release my Paperback project
  So that I can promote the current build

  Scenario:
    When I successfully run `paperback new .`
    And I fake git `diff --quiet --ignore-submodules HEAD`
    And I set my origin URL to "git@github.com:thoughtbot/a-nice-adventure.git"
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
