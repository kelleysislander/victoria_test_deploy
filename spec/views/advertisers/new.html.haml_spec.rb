require 'spec_helper'

describe "advertisers/new.html.haml" do
  before(:each) do
    assign(:advertiser, stub_model(Advertiser,
      :name => "MyString",
      :description => "MyString",
      :advertiser_type_id => 1
    ).as_new_record)
  end

  it "renders new advertiser form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => advertisers_path, :method => "post" do
      assert_select "input#advertiser_name", :name => "advertiser[name]"
      assert_select "input#advertiser_description", :name => "advertiser[description]"
      assert_select "input#advertiser_advertiser_type_id", :name => "advertiser[advertiser_type_id]"
    end
  end
end
