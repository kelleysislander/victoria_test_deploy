require 'spec_helper'

describe "retailer_categories/new.html.haml" do
  before(:each) do
    assign(:retailer_category, stub_model(RetailerCategory,
      :name => "MyString",
      :description => "MyString"
    ).as_new_record)
  end

  it "renders new retailer_category form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => retailer_categories_path, :method => "post" do
      assert_select "input#retailer_category_name", :name => "retailer_category[name]"
      assert_select "input#retailer_category_description", :name => "retailer_category[description]"
    end
  end
end
