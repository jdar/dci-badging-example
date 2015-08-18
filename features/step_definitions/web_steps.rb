require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

USER_TYPES = "peer|user|mentor|non-peer|thoughtleader"

# 3 peer items, 3 peers listed
Transform(/^(\d+) (?:#{USER_TYPES})s? (\w+?)s?$/) do |num,type|
  element = case type
  when /row/; "td"
  when /listed/, /item/,/bullet/; "li"
  when /definition/; "dd"
  when /term/; "dt"
  end
  results = all(element)
  expect(results.length).to eql(num.to_i)
  results
end

Transform(/^listed (?:#{USER_TYPES}) "(.*)"$/) do |text|
  find("li",text: /#{text}/)
end

Given(/^I populate db with school of "(.*)"$/) do |test_school|
  #ENV["RAILS_ENV"] = "cucumber"
  ActiveRecord::Base.establish_connection :cucumber
 
  ENV["SCHOOL_DIR"] = "input/#{test_school}"
  load "script/add_new_school"
end

When(/^I visit ("?.*?"?)$/) do |relative_url|
  #dont require quotes for the manage page
  relative_url.gsub!("\"","")

  visit path_to(relative_url)
end

Given(/^I fill in "(.*?)" with "(.*?)"$/) do |arg1, arg2|
  random_6_digits = (100000+rand(99999)).to_s
  arg2.gsub!("RANDOM", random_6_digits)

  if ENV["SUBOUT"] 
    arg2.gsub!(ENV["SUBOUT"], ENV["SUBIN"])
  end
  
  fill_in arg1, with: arg2
end

When(/^I fill in "(.*?)" with:$/) do |arg1, string|
  fill_in arg1, with: string
end

Given(/^I fill in "(.*?)" with ([\d\.]+)$/) do |arg1, arg2|
  fill_in arg1, with: arg2.to_f
end

When(/^I follow "([^\"]+)"$/) do |link_text|
  link = first("a",text: link_text)
  link || begin
    link = first("span", :text=>link_text)
    if link
      #STDOUT.puts "Maybe we should make this an 'a' link."
    end
  end
  if link.nil?
    raise "expected to find: #{link_text}"
  else
    link.click
  end
end

When /^I press "(.+)"$/ do |button_name|
  click_button button_name
end

When /^I select "(.+)" from "(.+)"$/ do |option, option_name|
  select option, :from => option_name
end

Given(/^I select "([^"]*?)"$/) do |str|
  select str
end

When /^I choose "(.+)"$/ do |radio_name|
  choose radio_name
end

When /^I check "(.+)"$/ do |checkbox_name|
  check checkbox_name
end

When(/^I uncheck "(.*?)"$/) do |arg1|
  page.uncheck arg1
end

When(/^I see "(.*?)" is not checked$/) do |arg1|
  expect(find_field arg1).to_not be_checked
end

When(/^I wait ([\d]+) seconds{0,1}$/) do |seconds|
  sleep seconds.to_i
end

Then(/^I see "([^\"]+)"$/) do |value|
  expect(page).to have_content value
end
Then(/^I see "([^\"]+)" in the html$/) do |value|
  page.body.to_s[/#{value}/]
end


And (/^I see that "(.*)" does not have option "(.*)"$/) do |fieldname, value|
  within field_labeled(fieldname) do
    option = first(:xpath, ".//option[text() = '#{value}']")
    raise "#{fieldname} should not exist" if option
  end
end

Then /^I see element "(.+)"$/ do |selector|
  find(:xpath,selector)
end
Then /^I see (\d+) elements "(.+)"$/ do |num, selector|
  find(:xpath,selector,count: num)
end

When(/^I reload the page$/) do
  visit current_path
end

# a bit hacky. 
Given(/^I see only the listed users:$/) do |*args|
  table, rest = *args
  table ||= @keep_hold_of_raw_table

  ul = find("ul")
  raise "wrong number" if ul.all("li").length != table.hashes.length

  within ul do 
    for row in table.hashes
      find(:xpath, "*",text: /#{row[:content] || row[:name]}/)
    end
  end
  @keep_hold_of_raw_table = nil
end

Given(/^(I see (\d+ \w+ \w+))$/) do |stp_name, objs|
  objs.length #checking here is redundant; already tested in Transform
end

Given(/^I don't see "(.*?)"$/) do |arg1|
  assert !page.body.include?(arg1)
end

Given(/^(.*) within subheading "(.*?)"$/) do |stp_text, h2_text|
  within find(:xpath,"//div[h2]",text: /^.{0,5}#{h2_text}/) do
    step stp_text
  end
end

#THIS IS A TOTAL HACK.
#Trying to scope where to look on the page.
#This will make the original step, without the "within subheading" part
def reconstitute_step(step_text, table)
  @keep_hold_of_raw_table = table
  step_text+":"
end

Given(/^(.*) within subheading "(.*?)":$/) do |stp_text, h2_text,table|
  within find(:xpath,"//div[h2]",text: /^.{0,5}#{h2_text}/) do
    step reconstitute_step(stp_text, table)
  end
end

Given(/^(.*) next to (\w+ \w+ ".*")$/) do |stp_text, element|
  within element do
    step stp_text
  end
end

And (/^I see that "(.*)" does not have option "(.*)"$/) do |fieldname, value|
  within field_labeled(fieldname) do
    option = first(:xpath, ".//option[text() = '#{value}']")
    raise "#{fieldname} should not exist" if option
  end
end

Then(/^I see that "(.*?)" is not an option$/) do |str|
  option = first(:xpath, ".//option[text() = '#{str}']")
  #byebug if option
  raise "#{str} should not be an option" if option
end 


Then(/^I see link "(.*?)" (\d+) times$/) do |str,num|
  find("a", str, count: num.to_i)
end
