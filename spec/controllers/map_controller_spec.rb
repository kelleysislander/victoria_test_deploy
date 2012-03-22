require 'spec_helper'

describe MapController do

  describe "GET 'retailers'" do
    it "returns http success" do
      get 'retailers'
      response.should be_success
    end
  end

end
