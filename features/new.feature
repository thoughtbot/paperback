Feature: New
  As a user
  I want a CLI to create a new Paperback project
  So that I can use the necessary files and directory structure

  Scenario: The path is the current directory
    Given I successfully run `paperback new .`
    And the following files should exist:
      | .gitignore            |
      | Gemfile               |
      | LICENSE               |
      | book/book.md          |
      | book/images/cover.pdf |
      | book/sample.md        |
      | example_app/.gitkeep  |
      | templates/pdf.latex   |

  Scenario: The path is a single directory
    Given I successfully run `paperback new foo`
    And the following files should exist:
      | foo/.gitignore            |
      | foo/Gemfile               |
      | foo/LICENSE               |
      | foo/book/book.md          |
      | foo/book/images/cover.pdf |
      | foo/book/sample.md        |
      | foo/example_app/.gitkeep  |
      | foo/templates/pdf.latex   |

  Scenario: The path is a nested directory
    Given I successfully run `paperback new foo/bar`
    And the following files should exist:
      | foo/bar/.gitignore            |
      | foo/bar/Gemfile               |
      | foo/bar/LICENSE               |
      | foo/bar/book/book.md          |
      | foo/bar/book/images/cover.pdf |
      | foo/bar/book/sample.md        |
      | foo/bar/example_app/.gitkeep  |
      | foo/bar/templates/pdf.latex   |
