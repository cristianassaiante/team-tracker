Given("I'm logged_in as a team member") do
  @team = create(:team)
  @team.save
  @user8 = create(:user, team_id: @team.id)
  @user8.save
  visit login_path
  fill_in "Email", with: @user8.email
  fill_in "Password", with: @user8.password
  click_button "Sign In"
end

When /I submit the profile form changing the school level/ do
  click_on "Profile"
  select 'PhD', from: 'user[school]'
  click_button "Update"
end

Then("I should see the profile page with the school level updated") do
  expect(page).to have_content("PhD")
end



