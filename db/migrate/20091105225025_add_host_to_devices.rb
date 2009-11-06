class AddHostToDevices < ActiveRecord::Migration
  def self.up
    add_column :devices, :host, :string
  end

  def self.down
    remove_column :devices, :host
  end
end
