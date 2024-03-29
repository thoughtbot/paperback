Feature: Stats
  As a user
  I want a CLI to report statistics for my Paperback project
  So that I can provide status updates to potential customers

  Scenario:
    When I successfully run `paperback new`
    And a file named "book/book.md" with:
      """
      % Book

      \mainmatter

      <<[chapters/one.md]
      <<[chapters/two.md]
      """
    And a file named "book/chapters/one.md" with:
      """
      # Part One

      ## Chapter title

      \clearpage

      A chapter that has been written.

      \clearpage
      """
    And a file named "book/chapters/two.md" with:
      """
      # Part Two

      STUB
      """
    And I create a git repo named "a-nice-adventure"
    When I successfully run `paperback stats`
    Then the output should contain:
      """
      +--------------------+---+
      | Pages              | 8 |
      | Pages Completed    | 7 |
      | Chapters Completed | 1 |
      | Chapters Remaining | 1 |
      +--------------------+---+
      """
