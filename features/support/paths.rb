module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in webrat_steps.rb
  #
  def path_to(page_name)
    case page_name
    
    when /the homepage/
      '/'
    when /the new network page/
      new_network_path

    when /the networks list page/
      networks_path

    when /the new vendor page/
      new_vendor_path

    when /the new device page/
      new_device_path

    when /the new device_management page/
      new_device_management_path

    when /the new device_management page/
      new_device_management_path

    
    # Add more mappings here.
    # Here is a more fancy example:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
