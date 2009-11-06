Feature: Manage vendors
  In order to identify by vendor devices connected to our network 
  As a network administrator
  I want to manage vendors
  
  Scenario: Register new vendor
    Given I am on the new vendor page
      And I fill in "Name" with "Mitel"
      And I fill in "Mac Address Prefix" with "00:00:00"
    When I press "Create"
    Then I should see "New vendor created."
      And I should see "Mitel"
      And I should have 1 vendors


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
