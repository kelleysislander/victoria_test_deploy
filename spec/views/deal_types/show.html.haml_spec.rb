require 'spec_helper'

describe "deal_types/show.html.haml" do
  before(:each) do
    @deal_type = assign(:deal_type, stub_model(DealType,
      :deal_type => "Deal Type",
      :description => "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Deal Type/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Description/)
  end
end
