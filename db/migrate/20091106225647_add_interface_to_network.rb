class AddInterfaceToNetwork < ActiveRecord::Migration
  def self.up
    add_column :networks, :interface, :string
  end

  def self.down
    remove_column :networks, :interface
  end
end
