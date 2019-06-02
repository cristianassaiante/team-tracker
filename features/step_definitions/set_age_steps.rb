Given("I'm logged in as a team_member") do
  @team = create(:team)
  @team.save
  @user7 = create(:user, team_id: @team.id)
  @user7.save
  visit login_path
  fill_in "Email", with: @user7.email
  fill_in "Password", with: @user7.password
  click_button "Sign In"
end

When /I submit the profile form changing the age/ do
  click_on "Profile"
  fill_in "Age", with: '22'
  click_button "Update"
end

Then("I should see the profile page with the age updated") do
  expect(page).to have_field("Age", with: '22')
end


