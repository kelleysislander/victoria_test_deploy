require "spec_helper"

describe RetailerCategoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/retailer_categories").should route_to("retailer_categories#index")
    end

    it "routes to #new" do
      get("/retailer_categories/new").should route_to("retailer_categories#new")
    end

    it "routes to #show" do
      get("/retailer_categories/1").should route_to("retailer_categories#show", :id => "1")
    end

    it "routes to #edit" do
      get("/retailer_categories/1/edit").should route_to("retailer_categories#edit", :id => "1")
    end

    it "routes to #create" do
      post("/retailer_categories").should route_to("retailer_categories#create")
    end

    it "routes to #update" do
      put("/retailer_categories/1").should route_to("retailer_categories#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/retailer_categories/1").should route_to("retailer_categories#destroy", :id => "1")
    end

  end
end
