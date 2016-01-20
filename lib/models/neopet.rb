class Neopet
  
  attr_reader :name, :strength, :defence, :movement, :species
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

  def get_points
    rand(1..10)
  end

  def get_species
    @species = Dir["public/img/neopets/*"].sample.split('.').first.split('/').last
  end

  def mood
    case @happiness
    when 1,2
      "depressed"
    when 3,4
      "sad"
    when 5,6
      "meh"
    when 7,8
      "happy"
    else
      "ecstatic"
    end
  end

end
