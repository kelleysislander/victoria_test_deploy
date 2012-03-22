require File.dirname(__FILE__) + '/../spec_helper'

describe TrafficRating do
  it "should be valid" do
    TrafficRating.new.should be_valid
  end
end
