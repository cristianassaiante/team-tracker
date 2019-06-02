Given("I'm logged in within a_team") do
  @team = create(:team)
  @team.save
  @user4 = create(:user, team_id: @team.id)
  @user4.save
  visit login_path
  fill_in "Email", with: @user4.email
  fill_in "Password", with: @user4.password
  click_button "Sign In"
end

When /I submit the profile form changing the username/ do
  click_on "Profile"
  fill_in "Username", with: @user4.username+"_updated"
  click_button "Update"
end

Then("I should see the profile page with the username updated") do
  expect(page).to have_field('Username', with: @user4.username+"_updated")
end