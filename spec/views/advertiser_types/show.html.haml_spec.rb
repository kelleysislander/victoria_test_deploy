require 'spec_helper'

describe "advertiser_types/show.html.haml" do
  before(:each) do
    @advertiser_type = assign(:advertiser_type, stub_model(AdvertiserType,
      :name => "Name",
      :description => "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Description/)
  end
end
