Given(/^I create a git repo named "([^"]*)"$/) do |name|
  git "init --initial-branch=main"
  git 'config user.email "test@example.com"'
  git "add ."
  git 'commit --no-gpg-sign --message "Initial commit"'
  git "remote add origin git@github.com:example/#{name}.git"
end

def git(subcommand)
  run_command_and_stop "git #{subcommand}"
end
