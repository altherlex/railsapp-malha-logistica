require 'rails_helper'

RSpec.describe "paths/edit", type: :view do
  before(:each) do
    @path = assign(:path, Path.create!(
      :local => "MyString",
      :begin_point => "MyString",
      :end_point => "MyString",
      :distance => 1
    ))
  end

  it "renders the edit path form" do
    render

    assert_select "form[action=?][method=?]", path_path(@path), "post" do

      assert_select "input#path_local[name=?]", "path[local]"

      assert_select "input#path_begin_point[name=?]", "path[begin_point]"

      assert_select "input#path_end_point[name=?]", "path[end_point]"

      assert_select "input#path_distance[name=?]", "path[distance]"
    end
  end
end
