class User
  # attrs here
  attr_reader :name
  attr_accessor :neopoints, :items, :neopets

  PET_NAMES = ["Angel", "Baby", "Bailey", "Bandit", "Bella", "Buddy", "Charlie", "Chloe", "Coco", "Daisy", "Lily", "Lucy", "Maggie", "Max", "Molly", "Oliver", "Rocky", "Shadow", "Sophie", "Sunny", "Tiger"]

  # initialize here
  def initialize(name)
  	@name = name
  	@neopoints = 2500
  	@items = []
  	@neopets = []
  end

  # other methods here
  def select_pet_name
  	PET_NAMES[rand(PET_NAMES.size)]
  end

  def make_file_name_for_index_page
  	name.downcase.gsub(/\s+/, "-")
  end

  def buy_item
  	if @neopoints >= 150 then
      @items << Item.new
  	  @neopoints -= 150
  	  "You have purchased a #{@items[-1].type}."
  	else
  	  "Sorry, you do not have enough Neopoints."
  	end  
  end

  def find_item_by_type(type)
  	items.select { |e| e.type == type }.first
  end

  def buy_neopet
  	if @neopoints >= 250 then
      new_neopet = Neopet.new(select_pet_name)
      @neopets << new_neopet
  	  @neopoints -= 250
  	  "You have purchased a #{new_neopet.species} named #{new_neopet.name}."
  	else
  	  "Sorry, you do not have enough Neopoints."
  	end  
  end

  def find_neopet_by_name(name)
  	@neopets.select { |e| e.name == name }.first
  end

  def sell_neopet_by_name(name)
  	neopet_found = find_neopet_by_name(name)
  	if neopet_found != nil then
  	  @neopets.delete(neopet_found)
  	  @neopoints += 200
  	  "You have sold #{name}. You now have #{@neopoints} neopoints."
  	else
  	  "Sorry, there are no pets named #{name}."
  	end
  end

  def feed_neopet_by_name(name)
  	neopet_found = find_neopet_by_name(name)
  	if neopet_found != nil then
      if neopet_found.happiness < 9 then
      	neopet_found.happiness += 2
      	"After feeding, #{name} is #{neopet_found.mood}."
      elsif neopet_found.happiness == 9 then
        neopet_found.happiness = 10
        "After feeding, #{name} is ecstatic."
      else
        "Sorry, feeding was unsuccessful as #{name} is already ecstatic."
      end  	
  	end
  end

  def give_present(type, name)
  	item = find_item_by_type(type)
  	neopet = find_neopet_by_name(name)
  	if item && neopet
      @items.delete(item)
      neopet.items << item
      neopet.happiness += 5
      neopet.happiness = 10 if neopet.happiness > 10
      "You have given a #{type} to #{name}, who is now #{neopet.mood}."
    else
      "Sorry, an error occurred. Please double check the item type and neopet name."
    end  
  end

  def make_index_page
  	html = "<!DOCTYPE html><html>"
  	html << "<head><title>#{@name}</title></head>"
  	html << "<body>"
  	html << "<h1>#{@name}</h1><h3><strong>Neopoints:</strong> #{@neopoints}</h3>"
  	html << "<h3>Neopets</h3>"
  	@neopets.each do |pet|
      html << "<img src=\"../../public/img/neopets/#{pet.species}.jpg\">"
      html << "<ul>"
      html << "<li><strong>Name:</strong> #{pet.name}</li>"
      html << "<li><strong>Mood:</strong> #{pet.mood}</li>"
      html << "<li><strong>Species:</strong> #{pet.species}</li>"
      html << "<li><strong>Strength:</strong> #{pet.strength}</li>"
      html << "<li><strong>Defence:</strong> #{pet.defence}</li>"
      html << "<li><strong>Movement:</strong> #{pet.movement}</li>"
  	end
  	html << "<h3>Items</h3>"
  	@items.each do |item|
  	  html << "<img src=\"../../public/img/items/#{item.type}.jpg\">"
  	  html << "<ul><li><strong>Type:</strong> #{item.formatted_type}</li></ul>"
  	end
  	File.write("views/users/#{make_file_name_for_index_page}.html", html)
  end
end