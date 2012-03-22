require File.dirname(__FILE__) + '/../spec_helper'

describe Redemption do
  it "should be valid" do
    Redemption.new.should be_valid
  end
end
