Feature: Build with scripts
  As a user
  I want to build a Paperback project with embedded scripts
  In order to automatically generate examples of command-line tools

  @announce
  Scenario: The input is valid
    When I successfully run `paperback new .`
    And I create a git repo named "a-nice-adventure"
    And a file named "book/book.md" with:
      """
      % Book

      \part{Part One}

      <<[content.md]
      """
    And a file named "book/content.md" with:
      """
      # Chapter one

      `# mkdir example
      `# cd example
      `# echo "Hello world" > example.txt
      `! cat example.txt
      `$ wc -w example.txt
      """

    When I successfully run `paperback build`

    Then the file "build/a-nice-adventure/a-nice-adventure.md" should contain:
      """
      % Book

      \part{Part One}

      # Chapter one

      ```
      Hello world
      $ wc -w example.txt
             2 example.txt
      ```
      """
    And the file "example/example.txt" should contain:
      """
      Hello world
      """
