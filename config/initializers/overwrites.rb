class Array
	def take_between_and_sort(begin_point, end_point)
		self
			.select{|i| i[:begin_point]==begin_point and i[:end_point]==end_point}
			.sort_by{|i| i[:distance]}
	end
	# Can't change the value of self (SyntaxError)
	#def take_between_and_sort!(begin_point, end_point)
 	#	self = self.take_between_and_sort(begin_point, end_point)
	#end
end