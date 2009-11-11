class Network < ActiveRecord::Base
  has_many :devices
  has_many :dhcp_options

  after_save { |network| network.to_dhcpd_conf }

  def address_list
    (1..254).to_a.collect { |octet| address +  "." + octet.to_s}
  end

  def to_dhcpd_conf
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
    %x[sudo -u #{usr} cp #{file_name} #{dir}]

    #send the bit below to a class method
    includer_filename = "/tmp/dhcp_subnets"
    f = File.open(includer_filename, 'w')  
      Network.all.each {|net|
        line = "include \"#{net.address.gsub(/\./, '_')}\";\n"
        f.write(line)  
      }
    f.close  
    %x[sudo -u #{usr} cp #{includer_filename} #{dir}]
  end

end
