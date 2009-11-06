Given /^the following vendors:$/ do |vendors|
  Vendor.create!(vendors.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) vendor$/ do |pos|
  visit vendors_url
  within("table > tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following vendors:$/ do |expected_vendors_table|
  expected_vendors_table.diff!(table_at('table').to_a)
end

Then /^I should have (\d+) vendors$/ do |v|
  Vendor.count.should == v.to_i
end
