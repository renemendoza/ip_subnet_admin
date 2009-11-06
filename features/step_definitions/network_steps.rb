Given /^the following networks:$/ do |networks|
  Network.create!(networks.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) network$/ do |pos|
  visit networks_url
  within("table > tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following networks:$/ do |expected_networks_table|
  expected_networks_table.diff!(table_at('table').to_a)
end
