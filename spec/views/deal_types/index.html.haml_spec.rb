require 'spec_helper'

describe "deal_types/index.html.haml" do
  before(:each) do
    assign(:deal_types, [
      stub_model(DealType,
        :deal_type => "Deal Type",
        :description => "Description"
      ),
      stub_model(DealType,
        :deal_type => "Deal Type",
        :description => "Description"
      )
    ])
  end

  it "renders a list of deal_types" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Deal Type".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
