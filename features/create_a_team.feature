Feature: I want to create a team
  As a user
  I want to insert a team name
  so that i can create a team

Scenario: User create a team
  Given I'm logged in with no team
  When I submit the team name field
  Then I should see the team home page