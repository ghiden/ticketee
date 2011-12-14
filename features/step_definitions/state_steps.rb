Given /^there is a state called "([^"]*)"$/ do |name|
  State.create!(:name => name)
end

Given /^"([^"]*)" has created a comment with this state$/ do |email, table|
  table.hashes.each do |attributes|
    attributes = attributes.merge!(:user => User.find_by_email!(email),
                                   :ticket => @project.tickets.first,
                                   :state => State.find_by_name!(attributes['state']))
    Comment.create!(attributes)
  end
end
