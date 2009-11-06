require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Vendor do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :mac_address_prefix => "value for mac_address_prefix"
    }
  end

  it "should create a new instance given valid attributes" do
    Vendor.create!(@valid_attributes)
  end
end
