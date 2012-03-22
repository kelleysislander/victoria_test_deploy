require File.dirname(__FILE__) + '/../spec_helper'

describe TrafficCamera do
  it "should be valid" do
    TrafficCamera.new.should be_valid
  end
end
