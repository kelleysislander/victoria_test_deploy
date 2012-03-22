require File.dirname(__FILE__) + '/../spec_helper'

describe TrafficCondition do
  it "should be valid" do
    TrafficCondition.new.should be_valid
  end
end
