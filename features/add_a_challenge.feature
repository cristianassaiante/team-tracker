Feature: I want to add a challenge
  As a user
  I want to add a challenge
  so that i can add stats to my profile

Scenario: User add a challenge
  Given I'm logged in within a team
  When I submit the add challenge form
  Then I should see the team home_page