Given /^I create a git repo named "([^"]*)"$/ do |name|
  git "init --template=/usr/share/git-core/templates"
  git "add ."
  git 'commit --no-gpg-sign --message "Initial commit"'
  git "remote add origin git@github.com:example/#{name}.git"
end

def git(subcommand)
  run_simple "git #{subcommand}"
end
