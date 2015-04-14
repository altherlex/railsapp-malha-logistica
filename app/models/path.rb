class Path < ActiveRecord::Base

	class << self
		# map id, begin_point, end_point, autonomy (km/L), price (R$/L)
		def better(map_id, begin_point, end_point, autonomy, price)
			routes = Path.where(local:map_id)
			#routes = routes.as_json
			#routes = routes.to_a.map(&:serializable_hash)
			analyse_routes = Path.analyse_paths(routes.to_a)
			
			Path.mount_result(
				analyse_routes, 
				begin_point, 
				end_point, 
				autonomy, 
				price)
		end	

  	#TODO: improve performance (test database speed)
  	def analyse_paths(arr_routes)
			arr_routes.each{|i| 
				# to acept ActiveRecord_Relation
				i = i.serializable_hash if i.respond_to?(:serializable_hash)
				#TODO: No detect. It needs to be recursive and take all path possibles
				hs_sequel_path = arr_routes.detect{|n| i['end_point']==n['begin_point']}
				unless hs_sequel_path.nil?
					arr_routes << i.merge({end_point:hs_sequel_path['end_point'], distance:i['distance']+hs_sequel_path['distance'], intermadiate_points:[hs_sequel_path['begin_point']]})
				end
			}
		rescue => e
			raise e.message
		end
		def mount_result(arr_routes, begin_point, end_point, autonomy, price)
			#raise arr_routes.inspect
			top = arr_routes.to_a.take_between_and_sort(begin_point, end_point).first
			#raise top.inspect
			{ 
				points: [top['begin_point'], top['end_point'], *top['intermadiate_points']].sort, 
				cost:Path.figure_cost(top['distance'], autonomy, price.to_f), distance:top['distance']
			}
  	end
  	# distance (Km)
  	# autonomy (Km/L)
  	# price (R$/L)
  	# figure: (distance/autonomy)*price
  	def figure_cost(distance, autonomy, price)
  		((distance.to_f/autonomy)*price)
  	end
  end
end

