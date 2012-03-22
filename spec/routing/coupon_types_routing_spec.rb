require "spec_helper"

describe DealTypesController do
  describe "routing" do

    it "routes to #index" do
      get("/deal_types").should route_to("deal_types#index")
    end

    it "routes to #new" do
      get("/deal_types/new").should route_to("deal_types#new")
    end

    it "routes to #show" do
      get("/deal_types/1").should route_to("deal_types#show", :id => "1")
    end

    it "routes to #edit" do
      get("/deal_types/1/edit").should route_to("deal_types#edit", :id => "1")
    end

    it "routes to #create" do
      post("/deal_types").should route_to("deal_types#create")
    end

    it "routes to #update" do
      put("/deal_types/1").should route_to("deal_types#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/deal_types/1").should route_to("deal_types#destroy", :id => "1")
    end

  end
end
