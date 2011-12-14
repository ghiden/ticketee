Feature: Creating states
  In order to be able to specify other states for tickets
  As an admin
  I want to add them to the application

  Background:
    Given there are the following users:
      | email              | password | admin |
      | admin@ticketee.com | password | true  |
    And I am signed in as them
    When I follow "Admin"
    And I follow "States"
    And I follow "New State"

  Scenario: Creating a state
    And I fill in "Name" with "Duplicate"
    And I press "Create State"
    Then I should see "State has been created."

  Scenario: Creating a state without valid attributes fails
    When I press "Create State"
    Then I should see "State has not been created."
    And I should see "Name can't be blank"

