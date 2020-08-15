class View
  def display(recipes)
    recipes.each_with_index do |recipe, index|
      puts "#{index + 1} - #{recipe.name} - #{recipe.description}"
    end
  end

  def to_do_list
    recipes.each_with_index do |recipe, index|
      puts "#{index + 1}. [#{done? "X" " "}]#{recipe.name} (#{recipe.pretime}) "
    end
  end

  def ask_for(parameter)
    puts "Please input the #{parameter}"
    gets.chomp
  end

  def what_scraper
  	puts 'What ingredient would you like a recipe for?'
  	recipe = gets.chomp
  	puts "Looking for #{recipe} recipes on the Internet..."
  	recipe
  end

  def display_scrape(items)
  	items.each_with_index do |item_key, index|
    	puts "#{index + 1} - #{item_key[:title]}"
		end
	end

	def ask_for_add_scrape
		puts 'Which recipe would you like to import? (enter index)'
		gets.chomp.to_i - 1
	end
end
