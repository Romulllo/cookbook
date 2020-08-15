class View
  def display(recipes)
    recipes.each_with_index do |recipe, index|
      puts "#{index + 1} - #{recipe.name} - #{recipe.description}"
    end
  end

  def ask_for(parameter)
    puts "Please input the #{parameter}"
    gets.chomp
  end
end