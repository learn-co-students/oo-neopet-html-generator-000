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
    possible_new_pet_name = PET_NAMES.sample
    until !@neopets.map{|m| m.name}.include?(possible_new_pet_name)
      possible_new_pet_name = PET_NAMES.sample
    end
    possible_new_pet_name
  end

  def make_file_name_for_index_page
    self.name.downcase.gsub(' ','-')
  end

  def buy_item
    if @neopoints > 149
      @items << Item.new
      @neopoints -= 150
      "You have purchased a #{@items.last.type}."
    else
      "Sorry, you do not have enough Neopoints."
    end
  end

  def find_item_by_type(type)
    @items.select{|i| i.type == type}.first
  end

  def buy_neopet
    if @neopoints > 249
      @neopets << Neopet.new(select_pet_name)
      @neopoints -= 250
      "You have purchased a #{@neopets.last.species} named #{@neopets.last.name}."
    else
      "Sorry, you do not have enough Neopoints."
    end
  end

  def find_neopet_by_name(name)
    @neopets.select{|n| n.name == name}.first
  end

  def sell_neopet_by_name(name)
    if neopet = find_neopet_by_name(name)
      @neopets.delete(neopet)
      @neopoints += 200
      "You have sold #{name}. You now have #{@neopoints} neopoints."
    else
      "Sorry, there are no pets named #{name}."
    end
  end

  def feed_neopet_by_name(name)
    neopet = find_neopet_by_name(name)
    suceess_phrase = "After feeding, #{neopet.name} is happy."
    case neopet.happiness
    when 10
      "Sorry, feeding was unsuccessful as #{neopet.name} is already ecstatic."
    when 9
      neopet.happiness = 10
      suceess_phrase
    else
      neopet.happiness += 2
      suceess_phrase
    end
  end

  def give_present(item_type, pet_name)
    item = @items.select{|i| i.type == item_type}.first
    neopet = @neopets.select{|n| n.name == pet_name}.first
    if item && neopet
      @items.delete(item)
      neopet.items << item
      neopet.happiness += 5
      neopet.happiness > 10 ? neopet.happiness = 10 : neopet.happiness
      "You have given a #{item.type} to #{neopet.name}, who is now #{neopet.mood}."
    else
      "Sorry, an error occurred. Please double check the item type and neopet name."
    end
  end

  def items_rendering_method
    @first_items_template, @second_items_template, @total_user_items = [], [], []
    if @neopets.first
      if @neopets.first.items
        @neopets.first.items.each{|item|
          mark_up = "<li><img src=\%..\/..\/public\/img\/items\/#{item.type}.jpg%><\/li><ul><li><strong>Type:<\/strong> #{item.format_type}<\/li><\/ul>"
          @first_items_template << mark_up
          @total_user_items <<  mark_up
        }          
      end
      @first_items_template = @first_items_template.to_s[2..-3].gsub(/\"\, \"/, " ").gsub(/%/, "\"")
    end
    if @neopets.count > 1
      if @neopets.last.items
        @neopets.last.items.each{|item|
          mark_up = "<li><img src=%..\/..\/public\/img/items\/#{item.type}.jpg%><\/li><ul><li><strong>Type:<\/strong> #{item.format_type}<\/li><\/ul>"
          @second_items_template << mark_up
          @total_user_items << mark_up        
        }           
      end
      @second_items_template = @second_items_template.to_s[2..-3].gsub(/\"\, \"/, " ").gsub(/%/, "\"")
    end
    @total_user_items = @total_user_items.to_s[2..-3].gsub(/\"\, \"/, " ").gsub(/%/, "\"")
  end

  def make_index_page
    items_rendering_method
    template =
        "<!DOCTYPE html>
        <html>
          <head>
            <link rel=\"stylesheet\" href=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css\">
            <link rel=\"stylesheet\" href=\"http://getbootstrap.com/examples/jumbotron-narrow/jumbotron-narrow.css\">
            <title>#{@name}<\/title>
          <\/head>
          <body>
            <div class=\"container\">

              <!-- begin jumbotron -->
              <div class=\"jumbotron\">
                <h1>#{@name}<\/h1>
                <h3><strong>Neopoints:<\/strong> #{@neopoints}<\/h3>
              <\/div>
              <!-- end jumbotron -->

              <div class=\"row marketing\">
                
                <!-- begin listing neopets -->
                <div class=\"col-lg-6\">
                  <h3>Neopets<\/h3>
                  <ul>

                  #{if @neopets.first

                    "<li><img src=\"../../public/img/neopets/#{@neopets.first.species}.jpg\"><\/li>
                      <ul>
                        <li><strong>Name:<\/strong> #{@neopets.first.name}<\/li>
                        <li><strong>Mood:<\/strong> #{@neopets.first.mood}<\/li>
                        <li><strong>Species:<\/strong> #{@neopets.first.species}<\/li>
                        <li><strong>Strength:<\/strong> #{@neopets.first.strength}<\/li>
                        <li><strong>Defence:<\/strong> #{@neopets.first.defence}<\/li>
                        <li><strong>Movement:<\/strong> #{@neopets.first.movement}<\/li>
                        <li><strong>Items:<\/strong><\/li>
                          <ul>
                          #{@first_items_template}
                          <\/ul>
                      <\/ul>"

                    end
                  }

                  #{if @neopets.count > 1

                    "<li><img src=\"../../public/img/neopets/#{@neopets.last.species}.jpg\"><\/li>
                      <ul>
                        <li><strong>Name:<\/strong> #{@neopets.last.name}<\/li>
                        <li><strong>Mood:<\/strong> #{@neopets.last.mood}<\/li>
                        <li><strong>Species:<\/strong> #{@neopets.last.species}<\/li>
                        <li><strong>Strength:<\/strong> #{@neopets.last.strength}<\/li>
                        <li><strong>Defence:<\/strong> #{@neopets.last.defence}<\/li>
                        <li><strong>Movement:<\/strong> #{@neopets.last.movement}<\/li>
                        <li><strong>Items:<\/strong><\/li>
                          <ul>
                          #{@second_items_template}
                          <\/ul>
                      <\/ul>"
                    end
                  }

                  <\/ul>
                <\/div>

        <div class=\"col-lg-6\">
          <h3>Items<\/h3>
          <ul>

            #{@total_user_items}

          <\/ul>
        <\/ul>
      <\/div>"
        
    File.open("views/users/#{make_file_name_for_index_page}.html",'w+') {|f|
      f.write(template)
    }
  end

end