Feature: Release
  As a user
  I want a CLI to release my Paperback project
  So that I can promote the current build

  Scenario:
    When I successfully run `paperback new .`
    And I fake git `diff --quiet --ignore-submodules HEAD`
    And I successfully run `paperback release`
    Then the following files should exist:
      | release/book.epub        |
      | release/book.html        |
      | release/book.mobi        |
      | release/book.pdf         |
      | release/images/cover.pdf |
      | release/images/cover.png |
      | release/sample.epub      |
      | release/sample.html      |
      | release/sample.mobi      |
      | release/sample.pdf       |
