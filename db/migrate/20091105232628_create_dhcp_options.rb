class CreateDhcpOptions < ActiveRecord::Migration
  def self.up
    create_table :dhcp_options do |t|
      t.string :option_name
      t.string :option_value
      t.integer :network_id

      t.timestamps
    end
  end

  def self.down
    drop_table :dhcp_options
  end
end
