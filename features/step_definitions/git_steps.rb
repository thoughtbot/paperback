def fake_git(cmd, stdout = '')
  git_command = 'fake-git'
  set_env 'GIT_COMMAND', git_command
  double_cmd "#{git_command} #{cmd}", :puts => stdout
end

Given /^I fake git `([^`]*)`$/ do |cmd|
  fake_git cmd
end

Given /^I fake git `([^`]*)` with:$/ do |cmd, stdout|
  fake_git cmd, stdout
end

When /^I set my origin URL to "([^"]*)"$/ do |url|
  fake_git 'config --get remote.origin.url', "#{url}\n"
end
