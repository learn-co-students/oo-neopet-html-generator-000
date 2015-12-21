class Item

  attr_reader :type

  def initialize
    @type = get_type
  end

  def get_type
    Dir["public/img/items/*"].sample.split(".").first.split("/").last
  end

  def format_type
    @type.split("_").map{|w| w.capitalize}.join(" ")
  end

  def formatted_type
    @type.split("_").map{|w| w.capitalize}.join(" ")
  end

end