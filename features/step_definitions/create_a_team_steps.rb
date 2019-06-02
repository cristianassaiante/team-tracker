Given("I'm logged in with no team") do
  @user1 = create(:user)
  visit login_path
  fill_in "Email", with: @user1.email
  fill_in "Password", with: @user1.password
  click_button "Sign In"
end

When /I submit the team name field/ do
  fill_in "teamname", with: "Cucumber_test_teamname"
  click_button "Create"
end

Then("I should see the team home page") do
  expect(page).to have_content("Latest CTFs")
end


