Feature: I want to join a team
  As a user
  I want to insert team token in the token field
  so that i can join a team

Scenario: Join a team
  Given I'm logged in with no_team
  When I submit the team token field
  Then I should see the team_home page