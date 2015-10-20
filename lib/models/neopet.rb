class Neopet
  # attrs here
  attr_reader :name, :species, :strength, :defence, :movement
  attr_accessor :happiness, :items

  # initialize here
  def initialize(name)
  	@name = name
  	@species = get_species
  	@strength = get_points
  	@defence = get_points
  	@movement = get_points
  	@happiness = get_points
  	@items = []
  end
  	
  # other methods here
  def get_species
  	list = get_species_list
  	list[rand(list.size)]
  end

  def get_points
  	rand(1..10)
  end	

  def mood
  	case happiness 
  	when 1, 2 then "depressed"
  	when 3, 4 then "sad"
    when 5, 6 then "meh"
    when 7, 8 then "happy"
    when 9, 10 then "ecstatic"
    end
  end
end