require File.dirname(__FILE__) + '/../spec_helper'

describe TrafficDataType do
  it "should be valid" do
    TrafficDataType.new.should be_valid
  end
end
