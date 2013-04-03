require 'spec_helper'

describe "travels/show" do
  before(:each) do
    @travel = assign(:travel, stub_model(Travel,
      :place => "Place",
      :body => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Place/)
    rendered.should match(/MyText/)
  end
end
