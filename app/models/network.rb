class Network < ActiveRecord::Base
  has_many :devices
  has_many :dhcp_options

  after_save { |network| Network.to_dhcpd_conf }

  def address_list
    (1..254).to_a.collect { |octet| address +  "." + octet.to_s}
  end

  def to_dhcpd_conf
    run_as_root = APP_CONFIG[:run_as_root]
    lines = []
    lines << "subnet #{address}.0 netmask #{netmask} {\n"
    dhcp_options.each {|o| lines << o.to_dhcpd_conf }
    devices.each {|d| lines << d.to_dhcpd_conf }
    lines << "}\n"
    file_name = "/tmp/#{address.gsub(/\./, '_')}"
    f = File.open(file_name, 'w')  
      lines.each {|line|
        f.write(line)  
      }
    f.close  
    usr = APP_CONFIG[:pwdless_user]
    dir = APP_CONFIG[:dhcpd_dir]

    if run_as_root
      %x[cp #{file_name} #{dir}]
    else
      %x[sudo -u #{usr} cp #{file_name} #{dir}]
    end

    #send the bit below to a class method
    includer_filename = "/tmp/dhcp_subnets"
    f = File.open(includer_filename, 'w')  
      Network.all.each {|net|
        line = "include \"#{dir}/#{net.address.gsub(/\./, '_')}\";\n"
        f.write(line)  
      }
    f.close  

    if run_as_root
      %x[cp #{includer_filename} #{dir}]
    else
      %x[sudo -u #{usr} cp #{includer_filename} #{dir}]
    end
  end

  def self.to_dhcpd_conf
    run_as_root = APP_CONFIG[:run_as_root]
    lines = []
    file_name = "/tmp/dhcpd_config"

    Network.all.each {|n|
      lines << "subnet #{n.address}.0 netmask #{n.netmask} {\n"
      n.dhcp_options.each {|o| lines << o.to_dhcpd_conf }
      n.devices.each {|d| lines << d.to_dhcpd_conf }
      lines << "}\n\n"
    }

    #lines << "subnet #{address}.0 netmask #{netmask} {\n"
    #dhcp_options.each {|o| lines << o.to_dhcpd_conf }
    #devices.each {|d| lines << d.to_dhcpd_conf }
    #lines << "}\n"
    #
    f = File.open(file_name, 'w')  
      lines.each {|line|
        f.write(line)  
      }
    f.close  
    usr = APP_CONFIG[:pwdless_user]
    dir = APP_CONFIG[:dhcpd_dir]

    if run_as_root
      %x[cp #{file_name} #{dir}]
    else
      %x[sudo -u #{usr} cp #{file_name} #{dir}]
    end

    #send the bit below to a class method
    #includer_filename = "/tmp/dhcp_subnets"
    #f = File.open(includer_filename, 'w')  
    #  Network.all.each {|net|
    #    line = "include \"#{dir}/#{net.address.gsub(/\./, '_')}\";\n"
    #    f.write(line)  
    #  }
    #f.close  

    #if run_as_root
    #  %x[cp #{includer_filename} #{dir}]
    #else
    #  %x[sudo -u #{usr} cp #{includer_filename} #{dir}]
    #end
  end
end
