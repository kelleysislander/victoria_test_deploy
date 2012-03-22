require 'spec_helper'

describe "retailer_categories/show.html.haml" do
  before(:each) do
    @retailer_category = assign(:retailer_category, stub_model(RetailerCategory,
      :name => "Name",
      :description => "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Description/)
  end
end
