Feature: Pandoc
  As a user
  I want to run custom Pandoc commands
  So that I can add complicated functionality

  Scenario:
    When I successfully run `paperback new`
    And I create a git repo named "a-nice-adventure"
    And I successfully run `paperback pandoc --to=html5 --output=book.html book/book.md`
    Then the following files should exist:
      | book.html |
