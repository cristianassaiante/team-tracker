Given("I am an authenticated user") do
  @user3 = create(:user)
  visit login_path
  fill_in "Email", with: @user3.email
  fill_in "Password", with: @user3.password
  click_button "Sign In"
end

When /I click on "Log out"/ do
  click_on "Logout"
end

Then("I should be not authenticated") do
  page.has_content?('Sign In')
end
