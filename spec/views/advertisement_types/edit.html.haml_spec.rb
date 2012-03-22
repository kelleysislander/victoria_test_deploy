require 'spec_helper'

describe "advertisement_types/edit.html.haml" do
  before(:each) do
    @advertisement_type = assign(:advertisement_type, stub_model(AdvertisementType,
      :name => "MyString",
      :description => "MyString"
    ))
  end

  it "renders the edit advertisement_type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => advertisement_types_path(@advertisement_type), :method => "post" do
      assert_select "input#advertisement_type_name", :name => "advertisement_type[name]"
      assert_select "input#advertisement_type_description", :name => "advertisement_type[description]"
    end
  end
end
