Given /^the following devices:$/ do |devices|
  Device.create!(devices.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) device$/ do |pos|
  visit devices_url
  within("table > tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following devices:$/ do |expected_devices_table|
  expected_devices_table.diff!(table_at('table').to_a)
end

Then /^I should have (\d+) devices$/ do |c|
    Device.count.should == c.to_i
end

