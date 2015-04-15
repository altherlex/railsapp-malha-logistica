require 'rails_helper'

RSpec.describe Path, type: :model do
	before(:all) do
		FactoryGirl.lint
		#input params
		@begin_point='A'
		@end_point='D'
		@autonomy=10
		@price=2.5		
	end

  it "better path" do
  	# map id, begin_point, end_point, autonomy (km/L), price (R$/L)
  	better_path = Path.better('Sampa', 'A', 'D', 10, 2.5)
		expect(better_path[:points]).to eq(["A", "B", "D"])
		expect(better_path[:distance]).to eq(25)
		expect(better_path[:cost]).to eq(6.25)
	end  
  it "Benchmark" do 
  	report = Benchmark.bm do |x|
			x.report("select map:"){ @routes = Path.where(local:'Sampa') }
			x.report("analyse routes:"){ @analyse_routes = Path.analyse_paths(@routes.as_json)}
			x.report("taking the best:"){ Path.mount_result(@analyse_routes, @begin_point, @end_point, @autonomy, @price) }
		end
		expect(report.size).to eq(3)
  end

	it "#analyse_paths for ActiveRecord_Relation" do
		routes = Path.limit(5)
		expect(Path.analyse_paths(routes).size).to eq(7)
	end
	it 'testing points for ActiveRecord_Relation' do
		top_restult = Path.mount_result(
			#Path.analyse_paths(Path.limit(5).as_json), 
			Path.analyse_paths(Path.where(local:'Sampa').as_json), 
			@begin_point, 
			@end_point, 
			@autonomy, 
			@price)
		expect(top_restult[:points]).to eq(["A", "B", "D"])
		expect(top_restult[:distance]).to eq(25)
		expect(top_restult[:cost]).to eq(6.25)
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
			@top_restult = Path.mount_result(
				Path.analyse_paths(@data), 
				@begin_point, 
				@end_point, 
				@autonomy, 
				@price)			
		end
		it 'testing points' do
			expect(@top_restult[:points]).to eq(["A", "B", "D"])
		end
		it 'testing distance figure' do
			expect(@top_restult[:distance]).to eq(25)
		end		
		it 'testing cost' do
			expect(@top_restult[:cost]).to eq(6.25)
		end
	end
end