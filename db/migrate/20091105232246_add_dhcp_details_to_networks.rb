class AddDhcpDetailsToNetworks < ActiveRecord::Migration

  def self.up
    add_column :networks, :netmask, :string
    add_column :networks, :range_start, :string
    add_column :networks, :range_end, :string
  end

  def self.down
    add_column :networks, :netmask
    add_column :networks, :range_start
    add_column :networks, :range_end
  end

end
