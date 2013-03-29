Feature: Review
  As a user
  I want a CLI to review pull requests for my Paperback project
  So that I can easily see new book content as it will appear

  Scenario:
    When I successfully run `paperback help review`
    Then the output should contain:
      """
      Usage:
        paperback review

      Review a pull request
      """
