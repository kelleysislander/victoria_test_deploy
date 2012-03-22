require 'spec_helper'

describe "advertisement_types/show.html.haml" do
  before(:each) do
    @advertisement_type = assign(:advertisement_type, stub_model(AdvertisementType,
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
