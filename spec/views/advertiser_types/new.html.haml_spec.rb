require 'spec_helper'

describe "advertiser_types/new.html.haml" do
  before(:each) do
    assign(:advertiser_type, stub_model(AdvertiserType,
      :name => "MyString",
      :description => "MyString"
    ).as_new_record)
  end

  it "renders new advertiser_type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => advertiser_types_path, :method => "post" do
      assert_select "input#advertiser_type_name", :name => "advertiser_type[name]"
      assert_select "input#advertiser_type_description", :name => "advertiser_type[description]"
    end
  end
end
