class Vendor < ActiveRecord::Base
  has_many :devices

  def self.vendors_list
    Vendor.all.collect {|v| {:name => v.name, :mac_prefix => v.mac_address_prefix, :vendor_id => v.id }}
  end

end
