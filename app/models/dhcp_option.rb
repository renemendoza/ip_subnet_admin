class DhcpOption < ActiveRecord::Base
  belongs_to :network

  after_save { |option| option.network.to_dhcpd.conf }

  def to_dhcpd_conf
    str = <<DHCPDCONF
    option #{option_name} #{option_value};
DHCPDCONF
  end
end
