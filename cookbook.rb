require_relative 'recipe'

class cookbook
  def initialize(recipe)
		@recipes = recipe
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

	# private

	# def Load_csv
	# end

	# def save_csv
	# end
end