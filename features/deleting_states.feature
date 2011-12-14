Feature: Deleting states
  In order to remove a state 
  As an admin
  I want to make them disappear

  Background:
    Given there are the following users:
      | email              | password | admin |
      | admin@ticketee.com | password | true  |
    And I am signed in as them
    Given there is a state called "Dammy"
    When I follow "Admin"
    And I follow "States"
    And I follow "Dammy"

  Scenario: Deleting a state
    And I follow "Delete State"
    Then I should see "State has been deleted."
    Then I should not see "Dammy"

  Scenario: Deleting a state should fail when it is assigned
    Given there is a project called "Internet Explorer"
    Given "admin@ticketee.com" has created a ticket for this project:
      | title                   | description                            |
      | Change a ticket's state | You should be able to create a comment |
    And "admin@ticketee.com" has created a comment with this state
      | text           | state   |
      | test test test | Dammy |
    And I follow "Delete State"
    Then I should see "State has assigned tickets."
    Then I should see "Dammy"
