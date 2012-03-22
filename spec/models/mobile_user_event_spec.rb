require File.dirname(__FILE__) + '/../spec_helper'

describe MobileUserEvent do
  it "should be valid" do
    MobileUserEvent.new.should be_valid
  end
end
