class Item

	attr_reader :type

	def initialize
		@type = get_type
	end

	def get_type
		Dir['public/img/items/*.jpg'].sample.split('public/img/items/')[1].gsub(".jpg", "")
	end

	def format_type
		@type.split('_').collect {|w| w.capitalize }.join(" ")
	end

end