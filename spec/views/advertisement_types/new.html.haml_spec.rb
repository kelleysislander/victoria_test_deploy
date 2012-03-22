require 'spec_helper'

describe "advertisement_types/new.html.haml" do
  before(:each) do
    assign(:advertisement_type, stub_model(AdvertisementType,
      :name => "MyString",
      :description => "MyString"
    ).as_new_record)
  end

  it "renders new advertisement_type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => advertisement_types_path, :method => "post" do
      assert_select "input#advertisement_type_name", :name => "advertisement_type[name]"
      assert_select "input#advertisement_type_description", :name => "advertisement_type[description]"
    end
  end
end
