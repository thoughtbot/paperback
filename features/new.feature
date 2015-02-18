Feature: New
  As a user
  I want a CLI to create a new Paperback project
  So that I can use the necessary files and directory structure

  Scenario:
    When I successfully run `paperback new`
    Then the following files should exist:
      | .gitignore            |
      | LICENSE               |
      | book/book.md          |
      | book/images/cover.pdf |
      | book/sample.md        |
      | example_app/.gitkeep  |
