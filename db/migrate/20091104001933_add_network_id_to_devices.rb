class AddNetworkIdToDevices < ActiveRecord::Migration
  def self.up
    add_column :devices, :network_id, :integer
  end

  def self.down
    remove_column :devices, :network_id
  end
end
