Feature: I want set an age
  As a user
  I want to have profile
  so that i can set an age

  Scenario: User Age
    Given I'm logged in as a team_member
    When I submit the profile form changing the age
    Then I should see the profile page with the age updated