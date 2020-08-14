require 'csv'
require_relative 'recipe'

class cookbook
	def initialize(csv_file)
		@csv_file = csv_file
		@recipes = load_csv
	end
	
	def all
		@recipes
	end
	
	def add(recipe)
		@recipes << recipe
	end

	def remove(index)
		@recipes.delete_at(index)
	end

	private

	def load_csv
		recipes_array = []
		CSV.foreach(@csv_file) do |row|
			recipes_array << Recipe.new(row[0], row[1])
		end
		recipes_array
	end

	def save_csv
	end
end