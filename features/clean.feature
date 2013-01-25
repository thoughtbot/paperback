Feature: Clean
  As a user
  I want a CLI to clean the project
  So that build artifacts can be removed

  Scenario: The build directory does not exist
    When I successfully run `paperback clean`
    Then a directory named "build" should not exist

  Scenario: The build directory is not empty
    Given an empty file named "build/book.md"
    When I successfully run `paperback clean`
    Then a directory named "build" should not exist
