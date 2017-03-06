class Item
  # attrs here
  attr_reader :type

  # initialize here
  def initialize
  	@type = get_type
  end

  # other methods here
  def get_type
    list = get_item_list
    list[rand(list.size)]
  end

  def format_type
  	type.split(/_/).map! { |e| e.capitalize }.join(" ")
  end	

  def formatted_type
  	format_type
  end	
end