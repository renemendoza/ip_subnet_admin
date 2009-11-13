class Device < ActiveRecord::Base
  belongs_to :network
  belongs_to :vendor
  validates_presence_of :name, :ip_address, :mac_address

#  after_save { |device| device.network.to_dhcpd_conf }
  after_save { |device| Network.to_dhcpd_conf }

  #this is view code should go in a helper
  def self.colors(vendor_name)
    colors = {:unknown => "#CCCCCC", :other => "#8B0000", :identified => "#66CD00"}

    if colors.keys.collect {|k| k.to_s}.include? vendor_name
      return colors[vendor_name.to_sym]
    else
      return colors[:identified]
    end

  end

  def to_dhcpd_conf
    str = <<DHCPDCONF

    host #{self.host} {
      hardware ethernet #{self.mac_address};
      fixed-address #{self.ip_address};
    }
DHCPDCONF
  end
end
