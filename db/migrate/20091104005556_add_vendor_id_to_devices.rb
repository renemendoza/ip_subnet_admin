class AddVendorIdToDevices < ActiveRecord::Migration
  def self.up
    add_column :devices, :vendor_id, :integer
  end

  def self.down
    remove_column :devices, :vendor_id
  end
end
