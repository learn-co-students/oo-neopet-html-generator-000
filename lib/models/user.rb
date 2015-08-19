class User
  attr_reader :name, :items, :neopets
  attr_accessor :neopoints

  PET_NAMES = ["Angel", "Baby", "Bailey", "Bandit", "Bella", "Buddy", "Charlie", "Chloe", "Coco", "Daisy", "Lily", "Lucy", "Maggie", "Max", "Molly", "Oliver", "Rocky", "Shadow", "Sophie", "Sunny", "Tiger"]

  def initialize(name)
  	@name = name
  	@neopoints = 2500
  	@items = []
  	@neopets = []
  end

  def select_pet_name
  	PET_NAMES.sample
  end

  def make_file_name_for_index_page
  	@name.downcase.split.join('-')
  end

  def buy_item
  	if @neopoints >= 150
  		@neopoints = @neopoints - 150
  		@items<<Item.new
  		"You have purchased a #{self.items[-1].type}."
  	else
  		"Sorry, you do not have enough Neopoints."
  	end
  end

  def find_item_by_type(item_type)
  	@items.each do |item|
  		if item.type == item_type
  			return item
  		end
  	end
  	nil
  end

  def buy_neopet
  	if @neopoints >= 250
  		@neopoints = @neopoints - 250
  		@neopets << Neopet.new(select_pet_name)
  		"You have purchased a #{self.neopets[-1].species} named #{self.neopets[-1].name}."
  	else
  		"Sorry, you do not have enough Neopoints."
  	end
  end

  def find_neopet_by_name(neopet_name)
  	@neopets.each do |neopet|
  		if neopet.name == neopet_name
  			return neopet
  		end
  	end
  	nil
  end

  def sell_neopet_by_name(neopet_name)
  	@neopets.each do |neopet|
  		if neopet.name == neopet_name
  			@neopets.delete(neopet)
  			@neopoints = @neopoints + 200
  			return "You have sold #{neopet_name}. You now have #{@neopoints} neopoints."
  		end
  	end
  	"Sorry, there are no pets named #{neopet_name}."
  end

  def feed_neopet_by_name(neopet_name)
  	pet = find_neopet_by_name(neopet_name)
  	if pet.happiness < 9
  		pet.happiness = pet.happiness + 2
  		"After feeding, #{neopet_name} is #{pet.mood}."
  	elsif pet.happiness == 9
  		pet.happiness = 10
  		"After feeding, #{neopet_name} is ecstatic."
  	else
  		"Sorry, feeding was unsuccessful as #{neopet_name} is already ecstatic."
  	end
  end

  def give_present(item_type, neopet_name)
  	pet = find_neopet_by_name(neopet_name)
  	present = find_item_by_type(item_type)
  	@items.delete(present)
  	present.type
  	pet.items << present
 		if pet.happiness < 5
 			pet.happiness = pet.happiness + 5
 		else
 			pet.happiness = 10
 		end
 		"You have given a #{item_type} to #{neopet_name}, who is now #{pet.mood}."
 		rescue
 		"Sorry, an error occurred. Please double check the item type and neopet name."
 	end

 	def make_index_page
 		page = File.new("views/users/#{make_file_name_for_index_page}.html", 'w')
 		page.puts("<!DOCTYPE html>")
 		page.puts("<head></head>")
 		page.puts("<h1>#{@name}</h1>")
 		page.puts("<h3><strong>Neopoints:</strong> #{@neopoints}</h3>")
 		page.puts("<h3>Neopets</h3>")
 		@neopets.each do |pet|
 			page.puts("<img src=\"../../public/img/neopets/#{pet.species}.jpg\">")
 			methods = [:name, :mood, :species, :strength, :defence, :movement]
 			methods.each do |method|
 				page.puts("<li><strong>#{method.to_s.capitalize}:<\/strong> #{pet.send(method)}<\/li>")
 			end
 		end
 		page.puts("<h3>Items</h3>")
 		@items.each do |item|
 			page.puts("<img src=\"..\/..\/public\/img\/items\/#{item.type}.jpg\">")
 			page.puts("<li><strong>Type:<\/strong> #{item.format_type}<\/li>")
 		end
 		page.close
 	end

end

  # def make_index_page
  #   File.open("views/users/#{make_file_name_for_index_page}.html", 'w') do |file| 
  #     file.write(get_html)
  #   end
  # end

  # def get_html
  #   html = "<!DOCTYPE html>\n\n<html>\n<head>\n<link rel=\"stylesheet\" href=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css\">\n<link rel=\"stylesheet\" href=\"http://getbootstrap.com/examples/jumbotron-narrow/jumbotron-narrow.css\">\n<title>#{self.name}</title>\n</head>\n<body>\n<div class=\"container\">\n<div class=\"jumbotron\">\n<h1>#{self.name}</h1>\n<h3><strong>Neopoints:</strong> #{self.neopoints}</h3>\n</div>\n<div class=\"row marketing\">\n"
  #   add_neopets_to_html(html)
  #   add_items_to_html(html)
  #   html << "</div>\n</body>\n</html>"
  # end

