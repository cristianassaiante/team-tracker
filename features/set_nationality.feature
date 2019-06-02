Feature: I want set a nationality
  As a user
  I want to have profile
  so that i can set a nationality

  Scenario: User Nationality
    Given I'm logged in as a team member
    When I submit the profile form changing the nationality
    Then I should see the profile page with the nationality updated