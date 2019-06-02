Feature: I want to set a username
  As a user
  I want to have profile
  so that i can set a username

Scenario: Set a username

  Given I'm logged in within a_team
  When I submit the profile form changing the username
  Then I should see the profile page with the username updated