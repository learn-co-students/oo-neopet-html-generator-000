class Neopet
  attr_reader :name, :species, :strength, :defence, :movement
  attr_accessor :happiness, :items

  def initialize(name)
  	@name = name
  	@strength = get_points
  	@defence = get_points
  	@movement = get_points
  	@happiness = get_points
  	@species = get_species
  	@items = []
  end

 	def get_species
		Dir['public/img/neopets/*.jpg'].sample.split('public/img/neopets/')[1].gsub(".jpg", "")
 	end

 	def get_points
 		[1,2,3,4,5,6,7,8,9,10].sample
 	end

 	def mood
 		if @happiness < 3
 			"depressed"
 		elsif @happiness > 2 && @happiness < 5
 			"sad"
 		elsif @happiness > 4 && @happiness < 7
 			"meh"
 		elsif @happiness > 6 && @happiness < 9
 			"happy"
 		else
 			"ecstatic"
 		end
 	end

end