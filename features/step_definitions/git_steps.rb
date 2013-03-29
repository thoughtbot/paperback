Given /^I create a git repo named "([^"]*)"$/ do |name|
  git 'init'
  git 'add .'
  git 'commit -m "Initial commit"'
  git "remote add origin git@github.com:example/#{name}.git"
end

def git(subcommand)
  run_simple "git #{subcommand}"
end
