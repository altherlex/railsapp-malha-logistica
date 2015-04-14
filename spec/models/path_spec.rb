require 'rails_helper'

RSpec.describe Path, type: :model do
	before(:all) do
		FactoryGirl.lint
	end
  it "better path" do
  	# map id, begin_point, end_point, autonomy (km/L), price (R$/L)
  	puts Path.better('Sampa', 'A', 'D', 10, 2.5).inspect
  end

	it "#analyse_paths for ActiveRecord_Relation" do
		routes = Path.where(local:"Sampa")
		analyse_routes = Path.analyse_paths(routes.to_a)
	end

  it "#figure_cost" do
		expect(Path.figure_cost('25', 10, 2.5)).to eq(6.25)
  end
  context "Rule" do 
		before(:all) do
			# begin_point: A
			# end_point: D
			# autonomy: 10 km/L
			# price: 2.5 (R$/L)
			@data = [	
				{begin_point:'A', end_point:'B', distance:10},
				{begin_point:'B', end_point:'D', distance:15},
				{begin_point:'A', end_point:'C', distance:20},
				{begin_point:'C', end_point:'D', distance:30},
				{begin_point:'B', end_point:'E', distance:50},
				{begin_point:'D', end_point:'E', distance:30}
			].map(&:with_indifferent_access)
			@begin_point='A'
			@end_point='D'
			@autonomy=10
			@price=2.5
		end
		it 'testing points' do
			top_restult = Path.mount_result(
				Path.analyse_paths(@data), 
				@begin_point, 
				@end_point, 
				@autonomy, 
				@price)
			expect(top_restult[:points]).to eq(["A", "B", "D"])
		end
		it 'testing cost' do
			top_restult = Path.mount_result(
				Path.analyse_paths(@data), 
				@begin_point, 
				@end_point, 
				@autonomy, 
				@price)
			expect(top_restult[:cost]).to eq(6.25)
		end
	end
end
=begin
a = [	
	{begin_point:'A', end_point:'B', autonomy:10},
	{begin_point:'B', end_point:'D', autonomy:15},
	{begin_point:'A', end_point:'C', autonomy:20},
	{begin_point:'C', end_point:'D', autonomy:30},
	{begin_point:'B', end_point:'E', autonomy:50},
	{begin_point:'D', end_point:'E', autonomy:30}
]

[ {:begin_point=>"A", :end_point=>"B", :autonomy=>10},
	{:begin_point=>"B", :end_point=>"D", :autonomy=>15},
	{:begin_point=>"A", :end_point=>"C", :autonomy=>20},
	{:begin_point=>"C", :end_point=>"D", :autonomy=>30}, 
	{:begin_point=>"B", :end_point=>"E", :autonomy=>50},
	{:begin_point=>"D", :end_point=>"E", :autonomy=>30},
	{:begin_point=>"A", :end_point=>"D", :autonomy=>25, :intermadiate_points=>["B"]},
	{:begin_point=>"B", :end_point=>"E", :autonomy=>45, :intermadiate_points=>["D"]},
	{:begin_point=>"A", :end_point=>"D", :autonomy=>50, :intermadiate_points=>["C"]},
	{:begin_point=>"C", :end_point=>"E", :autonomy=>60, :intermadiate_points=>["D"]},
	{:begin_point=>"A", :end_point=>"E", :autonomy=>55, :intermadiate_points=>["D"]},
	{:begin_point=>"A", :end_point=>"E", :autonomy=>80, :intermadiate_points=>["D"]}]

[{:begin_point=>"A", :end_point=>"D", :autonomy=>25},
	{:begin_point=>"B", :end_point=>"E", :autonomy=>45},
	{:begin_point=>"A", :end_point=>"D", :autonomy=>50},
	{:begin_point=>"C", :end_point=>"E", :autonomy=>60}, 
	{:begin_point=>"B", :end_point=>"E", :autonomy=>50},
	{:begin_point=>"D", :end_point=>"E", :autonomy=>30}
]
=end