Given("I'm logged in as a team member") do
  @team = create(:team)
  @team.save
  @user6 = create(:user, team_id: @team.id)
  @user6.save
  visit login_path
  fill_in "Email", with: @user6.email
  fill_in "Password", with: @user6.password
  click_button "Sign In"
end

When /I submit the profile form changing the nationality/ do
  click_on "Profile"
  fill_in "Nationality", with: 'Italy'
  click_button "Update"
end

Then("I should see the profile page with the nationality updated") do
  expect(page).to have_field("Nationality", with: 'Italy')
end

