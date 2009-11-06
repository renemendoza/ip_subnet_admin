Feature: Manage networks
  In order to manage our networks
  As a network administrator
  I want to create and edit networks
  
  Scenario: Register new network
    Given I am on the new network page
      And I fill in "Name" with "Telephony 1"
      And I fill in "Network Address" with "10.194.21.0"
    When I press "Create"
    Then I should see "New network created."
      And I should see "Telephony 1"
      And I should have 1 networks

  Scenario: Delete network
    Given the following networks:
      ||
      ||
      ||
      ||
      ||
    When I delete the 3rd network
    Then I should see the following networks:
      ||
      ||
      ||
      ||
