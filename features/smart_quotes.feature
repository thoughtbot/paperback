Feature: Smart Quotes
  As an author
  I want my regular quotes to be converted to curly quotes
  So that my book has better typography.

  Scenario: All packages
    Given I successfully run `paperback new`
    And a file named "book/book.md" with:
      """
      % Book

      # Introduction

      This is a "quotation".
      """
    And I successfully run `paperback build`
    Then the file "build/paperback/paperback.html" should contain:
      """
      “quotation”
      """
