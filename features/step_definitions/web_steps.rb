require 'capybara/rails'

Given /^I am on (.+)$/ do |page_name|
  if page_name == 'the homepage'
    visit(root_path)
  end
end

When /^I follow "([^"]*)"$/ do |arg1|
  click_link(arg1)
end

When /^I fill in "([^"]*)" with "([^"]*)"$/ do |arg1, arg2|
  fill_in(arg1, {:with => arg2})
end

When /^I press "([^"]*)"$/ do |arg1|
  click_button(arg1)
end

Then /^I should see "([^"]*)"$/ do |arg1|
  page.has_content?(arg1).should be_true
end

Then /^I should not see "([^"]*)"$/ do |arg1|
  page.has_content?(arg1).should be_false
end

Then /^I should be on the project page for "([^"]*)"$/ do |arg1|
  current_path.should == project_path(Project.find_by_name!(arg1))
end

Given /^there is a project called "([^"]*)"$/ do |name|
  Factory(:project, :name => name)
end

