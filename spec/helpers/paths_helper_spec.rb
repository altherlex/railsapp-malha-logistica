require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the PathsHelper. For example:
#
# describe PathsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe PathsHelper, type: :helper do
	before(:all) do
		@an_array = [
			{:begin_point=>"A", :end_point=>"B", :distance=>10}, 
			{:begin_point=>"B", :end_point=>"D", :distance=>15}, 
			{:begin_point=>"A", :end_point=>"C", :distance=>20}, 
			{:begin_point=>"C", :end_point=>"D", :distance=>30}, 
			{:begin_point=>"B", :end_point=>"E", :distance=>50}, 
			{:begin_point=>"D", :end_point=>"E", :distance=>30}, 
			{:begin_point=>"A", :end_point=>"D", :distance=>25, :intermadiate_points=>["B"]}, 
			{:begin_point=>"B", :end_point=>"E", :distance=>45, :intermadiate_points=>["D"]}, 
			{:begin_point=>"A", :end_point=>"D", :distance=>50, :intermadiate_points=>["C"]}, 
			{:begin_point=>"C", :end_point=>"E", :distance=>60, :intermadiate_points=>["D"]}, 
			{:begin_point=>"A", :end_point=>"E", :distance=>55, :intermadiate_points=>["D"]}, 
			{:begin_point=>"A", :end_point=>"E", :distance=>80, :intermadiate_points=>["D"]}
		]
		@other_array = [
			{"begin_point"=>"A", "end_point"=>"B", "distance"=>10}, 
			{"begin_point"=>"B", "end_point"=>"D", "distance"=>15}, 
			{"begin_point"=>"A", "end_point"=>"C", "distance"=>20}, 
			{"begin_point"=>"C", "end_point"=>"D", "distance"=>30}, 
			{"begin_point"=>"B", "end_point"=>"E", "distance"=>50}, 
			{"begin_point"=>"D", "end_point"=>"E", "distance"=>30}, 
			{"begin_point"=>"A", "end_point"=>"D", "distance"=>25, "intermadiate_points"=>["B"]}, 
			{"begin_point"=>"B", "end_point"=>"E", "distance"=>45, "intermadiate_points"=>["D"]}, 
			{"begin_point"=>"A", "end_point"=>"D", "distance"=>50, "intermadiate_points"=>["C"]}, 
			{"begin_point"=>"C", "end_point"=>"E", "distance"=>60, "intermadiate_points"=>["D"]}, 
			{"begin_point"=>"A", "end_point"=>"E", "distance"=>55, "intermadiate_points"=>["D"]}, 
			{"begin_point"=>"A", "end_point"=>"E", "distance"=>80, "intermadiate_points"=>["D"]}
		]
	end
	#it "Array" do
	#	expect(helper.concat_strings("this","that")).to eq("this that")
	#end
	context "Array w/ simbol key hash" do 
		it "#take_between_and_sort instance method" do 
			expect([].methods.select{|i| i.to_s.include?('take_between_and_sort')}.empty?).to be false
		end
		it '#take_between_and_sort test take between' do
			expect(@an_array.take_between_and_sort('A', 'D').size).to eq(2)
		end
		it "#take_between_and_sort test sort" do
			first = @an_array.take_between_and_sort('A', 'D').first
			last = @an_array.take_between_and_sort('A', 'D').last
			expect(first[:distance]).to be < last[:distance]
		end
		#it '#take_between_and_sort!' do
		#	@an_array.take_between_and_sort!('A', 'D')
		#	expect(@an_array.size).to eq(2)
		#end				
  end # context Array	
	context "Array w/ string key hash" do 
		it '#take_between_and_sort test take between' do
			expect(@other_array.take_between_and_sort('A', 'D').size).to eq(2)
		end
		it "#take_between_and_sort test sort" do
			first = @other_array.take_between_and_sort('A', 'D').first
			last = @other_array.take_between_and_sort('A', 'D').last
			expect(first[:distance]).to be < last[:distance]
		end
  end # context Array	  
end
