require 'csv'
require_relative 'recipe'

class Cookbook
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = load_csv
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_csv
  end


  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    save_csv
  end

  private

  def load_csv
    recipe_array = []

    CSV.foreach(@csv_file_path) do |row|
      recipe_array << Recipe.new(row[0], row[1])
    end
    recipe_array
  end

  def save_csv
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }

    CSV.open(@csv_file_path, 'wb', csv_options) do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description]
      end
    end
  end

end
