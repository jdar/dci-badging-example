
Given(/^I login as "(.*?)"$/) do |arg1|
  logout_link = first("a", text: "Sign out")
  if logout_link
    logout_link.click
  end
  fill_in "Email", with: arg1
  fill_in "Password", with: "password"
  step 'I press "Sign in"'
end
