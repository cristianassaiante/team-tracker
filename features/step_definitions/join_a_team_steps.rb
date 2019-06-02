Given("I'm logged in with no_team") do
  @team = create(:team, token: "a41b343286b2acba985ad5105b73b8a20d2ea6d94f354f05a36790f9f043aff5")
  @team.save
  @user1 = create(:user)
  visit login_path
  fill_in "Email", with: @user1.email
  fill_in "Password", with: @user1.password
  click_button "Sign In"
end

When /I submit the team token field/ do
  fill_in 'Team token', with: '3c45656dbabb777b6025d368755b2ea6'
  click_button 'Join'
end

Then("I should see the team_home page") do
  expect(page).to have_content("Latest CTFs")
end
