require 'rails_helper'

RSpec.describe "paths/show", type: :view do
  before(:each) do
    @path = assign(:path, Path.create!(
      :local => "Local",
      :begin_point => "Begin Point",
      :end_point => "End Point",
      :distance => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Local/)
    expect(rendered).to match(/Begin Point/)
    expect(rendered).to match(/End Point/)
    expect(rendered).to match(/1/)
  end
end
