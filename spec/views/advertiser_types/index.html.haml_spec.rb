require 'spec_helper'

describe "advertiser_types/index.html.haml" do
  before(:each) do
    assign(:advertiser_types, [
      stub_model(AdvertiserType,
        :name => "Name",
        :description => "Description"
      ),
      stub_model(AdvertiserType,
        :name => "Name",
        :description => "Description"
      )
    ])
  end

  it "renders a list of advertiser_types" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
