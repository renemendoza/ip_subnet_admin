require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Device do
  before(:each) do
    @valid_attributes = {
      :mac_address => "value for mac_address",
      :ip_address => "value for ip_address",
      :name => "value for name"
    }
  end

  it "should create a new instance given valid attributes" do
    Device.create!(@valid_attributes)
  end
end
