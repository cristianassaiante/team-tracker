Given("I'm logged in within_a_team") do
  @team = create(:team)
  @team.save
  @user5 = create(:user, team_id: @team.id)
  @user5.save
  visit login_path
  fill_in "Email", with: @user5.email
  fill_in "Password", with: @user5.password
  click_button "Sign In"
end

When /I submit the profile form changing the personal website/ do
  click_on "Profile"
  fill_in "Website", with: @user5.email.partition("@").last
  click_button "Update"
end

Then("I should see the profile page with the personal website updated") do
  expect(page).to have_field("Website", with: @user5.email.partition("@").last)
end
