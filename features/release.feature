Feature: Release
  As a user
  I want a CLI to release my Paperback project
  So that I can push build artifacts to S3

  Scenario:
    When I successfully run `paperback help release`
    Then the output should contain:
      """
      Usage:
        paperback release

      Push build artifacts to S3
      """
