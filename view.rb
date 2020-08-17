class View
  def display(recipes)
    recipes.each_with_index do |recipe, index|
      puts "#{index + 1}. #{recipe.name}:"
      puts "#{recipe.description}"
      puts "Ready in just: #{recipe.prep_time}." if recipe.prep_time
      puts "It's so #{recipe.difficulty} to make it!" if recipe.difficulty
    end
  end

  def ask_user_for(stuff)
    puts "#{stuff.capitalize}?"
    gets.chomp
  end

  def ask_user_for_index
    puts "Index?"
    gets.chomp.to_i - 1
  end

  def ask_for_ingredient_to_import
    puts "What ingredient would you like a recipe for?"
    ingredient = gets.chomp
    puts "Looking for \"#{ingredient}\" recipes on the Internet..."
    return ingredient
  end

  def print(message)
    puts message
  end

  def show_recipes(array_of_hashes_of_recipes)
    array_of_hashes_of_recipes.each_with_index do |hash_of_recipe, index|
      puts "#{index + 1} - #{hash_of_recipe[:name]}"
    end
  end
end