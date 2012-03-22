require File.dirname(__FILE__) + '/../spec_helper'

describe RedemptionPassphrase do
  it "should be valid" do
    RedemptionPassphrase.new.should be_valid
  end
end
