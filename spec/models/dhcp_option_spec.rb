require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DhcpOption do
  before(:each) do
    @valid_attributes = {
      :option_name => "value for option_name",
      :option_value => "value for option_value",
      :network_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    DhcpOption.create!(@valid_attributes)
  end
end
