require File.dirname(__FILE__) + '/../spec_helper'

describe TrafficConditionHistorical do
  it "should be valid" do
    TrafficConditionHistorical.new.should be_valid
  end
end
