Feature: Manage devices
  In order to manage network ip address space
  As a network administrator
  I want to assign ip address to valid devices
  
  Scenario: Register new device
    Given the following networks:
      | name | address    |
      | tele | 10.194.1.0 |

    When I am on the networks list page
      And I follow "tele"
      And I follow "New Device"
      And I fill in "Name" with "Ext 123"
      And I fill in "IP Address" with "127.0.0.1"
      And I fill in "Mac Address" with "00:00:00:00:00"
      And I press "Create"
    Then I should see "New device created."
      And I should see "Ext 123"
      And I should have 1 devices

  Scenario: Delete device
    Given the following devices:
      ||
      ||
      ||
      ||
      ||
    When I delete the 3rd device
    Then I should see the following devices:
      ||
      ||
      ||
      ||
