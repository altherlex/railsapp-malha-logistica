class Path < ActiveRecord::Base

	attr_accessor :intermadiate_points

	def self.massive_new(*params)
		p = params.map!(&:strip)
		new({local:p[0], begin_point:p[1], end_point:p[2], distance:p[3]})
	end
	class << self
		# map id, begin_point, end_point, autonomy (km/L), price (R$/L)
		def better(map_id, begin_point, end_point, autonomy, price)
			routes = Path.where(local:map_id)
			#routes = routes.as_json
			#routes = routes.to_a.map(&:serializable_hash)
			analyse_routes = Path.analyse_paths(routes.as_json)
			Path.mount_result(
				analyse_routes, 
				begin_point, 
				end_point, 
				autonomy, 
				price)
		end	

  	#TODO: improve performance (test logical in database to more speed)
  	def analyse_paths(arr_routes)
  		#arr_routes = arr_routes.as_json if arr_routes.is_a? String
			arr_routes.each{|i| 
				# to acept ActiveRecord_Relation
				i = i.serializable_hash if i.respond_to?(:serializable_hash)
				#TODO: No detect. It needs to be recursive and take all path possibles
				hs_sequel_path = arr_routes.detect{|n| i['end_point']==n['begin_point']}
				unless hs_sequel_path.nil?
					new_i = i.clone
					new_i['end_point'] = hs_sequel_path['end_point']
					new_i['distance'] = new_i['distance'].to_f+hs_sequel_path['distance'].to_f
					new_i['intermadiate_points'] = [hs_sequel_path['begin_point']]
					arr_routes << new_i
				end
			}
		end
		def mount_result(arr_routes, begin_point, end_point, autonomy, price)
			top = arr_routes.to_a.take_between_and_sort(begin_point, end_point).first
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
  		((distance.to_f/autonomy.to_f)*price.to_f)
  	end
  end
end

