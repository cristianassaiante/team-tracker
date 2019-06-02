Feature: I want set a personal website
  As a user
  I want to have profile
  so that i can set a personal website

Scenario: Personal website
  Given I'm logged in within_a_team
  When I submit the profile form changing the personal website
  Then I should see the profile page with the personal website updated