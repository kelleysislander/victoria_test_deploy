require "spec_helper"

describe AdvertisementTypesController do
  describe "routing" do

    it "routes to #index" do
      get("/advertisement_types").should route_to("advertisement_types#index")
    end

    it "routes to #new" do
      get("/advertisement_types/new").should route_to("advertisement_types#new")
    end

    it "routes to #show" do
      get("/advertisement_types/1").should route_to("advertisement_types#show", :id => "1")
    end

    it "routes to #edit" do
      get("/advertisement_types/1/edit").should route_to("advertisement_types#edit", :id => "1")
    end

    it "routes to #create" do
      post("/advertisement_types").should route_to("advertisement_types#create")
    end

    it "routes to #update" do
      put("/advertisement_types/1").should route_to("advertisement_types#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/advertisement_types/1").should route_to("advertisement_types#destroy", :id => "1")
    end

  end
end
