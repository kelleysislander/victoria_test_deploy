require 'spec_helper'

describe "retailer_categories/index.html.haml" do
  before(:each) do
    assign(:retailer_categories, [
      stub_model(RetailerCategory,
        :name => "Name",
        :description => "Description"
      ),
      stub_model(RetailerCategory,
        :name => "Name",
        :description => "Description"
      )
    ])
  end

  it "renders a list of retailer_categories" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
