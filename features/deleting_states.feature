Feature: Deleting states
  In order to remove a state 
  As an admin
  I want to make them disappear

  Scenario: Deleting a state
    Given there are the following users:
      | email              | password | admin |
      | admin@ticketee.com | password | true  |
    And I am signed in as them
    Given there is a state called "Dammy"
    When I follow "Admin"
    And I follow "States"
    And I follow "Dammy"
    And I follow "Delete State"
    Then I should see "State has been deleted."
    Then I should not see "Dammy"
