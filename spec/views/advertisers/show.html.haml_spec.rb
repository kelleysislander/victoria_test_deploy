require 'spec_helper'

describe "advertisers/show.html.haml" do
  before(:each) do
    @advertiser = assign(:advertiser, stub_model(Advertiser,
      :name => "Name",
      :description => "Description",
      :advertiser_type_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Description/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
