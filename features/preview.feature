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
      | build/a-nice-adventure/a-nice-adventure.pdf |
      | build/a-nice-adventure/images/cover.pdf     |
