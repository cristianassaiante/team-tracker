Given("I'm logged in within a team") do
  @team = create(:team)
  @team.save
  @user2 = create(:user, team_id: @team.id)
  @user2.save
  visit login_path
  fill_in "Email", with: @user2.email
  fill_in "Password", with: @user2.password
  click_button "Sign In"
end

When /I submit the add challenge form/ do
  click_on "Add challenge"
  @chal1 = create(:chal1)
  fill_in "chall_name", with: @chal1.name
  fill_in "points", with: @chal1.points
  click_button "Submit"
end

Then("I should see the team home_page") do
  expect(page).to have_content("Latest CTFs")
end
