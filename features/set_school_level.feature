Feature: I want set a school level
  As a user
  I want to have profile
  so that i can set a school level

  Scenario: User School Level
    Given I'm logged_in as a team member
    When I submit the profile form changing the school level
    Then I should see the profile page with the school level updated