require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Network do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :address => "value for address"
    }
  end

  it "should create a new instance given valid attributes" do
    Network.create!(@valid_attributes)
  end
end
