require 'spec_helper'

describe "retailer_categories/edit.html.haml" do
  before(:each) do
    @retailer_category = assign(:retailer_category, stub_model(RetailerCategory,
      :name => "MyString",
      :description => "MyString"
    ))
  end

  it "renders the edit retailer_category form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => retailer_categories_path(@retailer_category), :method => "post" do
      assert_select "input#retailer_category_name", :name => "retailer_category[name]"
      assert_select "input#retailer_category_description", :name => "retailer_category[description]"
    end
  end
end
