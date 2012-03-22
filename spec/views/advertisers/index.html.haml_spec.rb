require 'spec_helper'

describe "advertisers/index.html.haml" do
  before(:each) do
    assign(:advertisers, [
      stub_model(Advertiser,
        :name => "Name",
        :description => "Description",
        :advertiser_type_id => 1
      ),
      stub_model(Advertiser,
        :name => "Name",
        :description => "Description",
        :advertiser_type_id => 1
      )
    ])
  end

  it "renders a list of advertisers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
