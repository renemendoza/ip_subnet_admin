Feature: Manage vendors
  In order to identify by vendor devices connected to our network 
  As a network administrator
  I want to manage vendors
  
  Scenario: Register new vendor
    Given I am on the new vendor page
    And I press "Create"

  Scenario: Delete vendor
    Given the following vendors:
      ||
      ||
      ||
      ||
      ||
    When I delete the 3rd vendor
    Then I should see the following vendors:
      ||
      ||
      ||
      ||
