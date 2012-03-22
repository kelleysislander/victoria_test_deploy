require File.dirname(__FILE__) + '/../spec_helper'

describe DeviceRedemption do
  it "should be valid" do
    DeviceRedemption.new.should be_valid
  end
end
