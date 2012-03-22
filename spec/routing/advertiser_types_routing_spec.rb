require "spec_helper"

describe AdvertiserTypesController do
  describe "routing" do

    it "routes to #index" do
      get("/advertiser_types").should route_to("advertiser_types#index")
    end

    it "routes to #new" do
      get("/advertiser_types/new").should route_to("advertiser_types#new")
    end

    it "routes to #show" do
      get("/advertiser_types/1").should route_to("advertiser_types#show", :id => "1")
    end

    it "routes to #edit" do
      get("/advertiser_types/1/edit").should route_to("advertiser_types#edit", :id => "1")
    end

    it "routes to #create" do
      post("/advertiser_types").should route_to("advertiser_types#create")
    end

    it "routes to #update" do
      put("/advertiser_types/1").should route_to("advertiser_types#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/advertiser_types/1").should route_to("advertiser_types#destroy", :id => "1")
    end

  end
end
