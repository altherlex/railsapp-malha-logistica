require 'rails_helper'

RSpec.describe "paths/index", type: :view do
  before(:each) do
    assign(:paths, [
      Path.create!(
        :local => "Local",
        :begin_point => "Begin Point",
        :end_point => "End Point",
        :distance => 1
      ),
      Path.create!(
        :local => "Local",
        :begin_point => "Begin Point",
        :end_point => "End Point",
        :distance => 1
      )
    ])
  end

  it "renders a list of paths" do
    render
    assert_select "tr>td", :text => "Local".to_s, :count => 2
    assert_select "tr>td", :text => "Begin Point".to_s, :count => 2
    assert_select "tr>td", :text => "End Point".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
