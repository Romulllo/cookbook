require_relative 'view'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    # ask the view to show all of the recipes in the cookbook
    recipes = @cookbook.all
    @view.display(recipes)
  end

  def create
    # ask the user for the name
    name = @view.ask_for('name')
    # ask the user for the description
    description = @view.ask_for('description')
    # create a new recipe
    new_recipe = Recipe.new(name, description)
    # add this recipe to my cookbook
    @cookbook.add_recipe(new_recipe)
  end

  def destroy
    # ask the user for an index to destroy
    index = @view.ask_for('index').to_i - 1
    @cookbook.remove_recipe(index)
  end
end
