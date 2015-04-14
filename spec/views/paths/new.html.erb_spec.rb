require 'rails_helper'

RSpec.describe "paths/new", type: :view do
  before(:each) do
    assign(:path, Path.new(
      :local => "MyString",
      :begin_point => "MyString",
      :end_point => "MyString",
      :distance => 1
    ))
  end

  it "renders new path form" do
    render

    assert_select "form[action=?][method=?]", paths_path, "post" do

      assert_select "input#path_local[name=?]", "path[local]"

      assert_select "input#path_begin_point[name=?]", "path[begin_point]"

      assert_select "input#path_end_point[name=?]", "path[end_point]"

      assert_select "input#path_distance[name=?]", "path[distance]"
    end
  end
end
