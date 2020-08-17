require 'open-uri'
require 'nokogiri'

require_relative "view"
require_relative "recipe"

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  # USER ACTIONS

  def list
    display_recipes
  end

  def create
    # ask user for a name
    name = @view.ask_user_for("name")
    # ask user for a description
    description = @view.ask_user_for("description")
    # create recipe
    recipe = Recipe.new(name, description)
    # store in cookbook
    @cookbook.add_recipe(recipe)
    # display
    display_recipes
  end

  def destroy
    # display recipes
    display_recipes
    # ask user for index (view)
    index = @view.ask_user_for_index
    # remove from cookbook (repo)
    @cookbook.remove_recipe(index)
    # display
    display_recipes
  end

  def import
    ingredient = @view.ask_for_ingredient_to_import
    array_of_hashes_of_recipes = scrape_bbc_good_foods(ingredient)
    @view.show_recipes(array_of_hashes_of_recipes)
    index = @view.ask_user_for_index

    recipe_hash = array_of_hashes_of_recipes[index]
    @view.print("Importing \"#{recipe_hash[:name]}\"...")

    new_recipe = Recipe.new(recipe_hash[:name],
                            recipe_hash[:description],
                            recipe_hash[:time],
                            recipe_hash[:difficulty])

    @cookbook.add_recipe(new_recipe)
  end

#-----------------------------------------------------------------------------------
  private

  def display_recipes
    recipes = @cookbook.all
    @view.display(recipes)
  end

  def scrape_bbc_good_foods(ingredient)
    url = "https://www.bbcgoodfood.com/search/recipes?query=#{ingredient}"

    html_file = open(url).read
    html_doc = Nokogiri::HTML(html_file)

    css_parent_element = '.node.node-recipe.node-teaser-item.clearfix'
    name_css = 'h3 > a'
    description_css = ".field-item.even"
    difficulty_css = 'li.teaser-item__info-item.teaser-item__info-item--skill-level'
    time_css = 'li.teaser-item__info-item.teaser-item__info-item--total-time > span'

    array = []
    html_doc.search(css_parent_element).first(5).each do |element|
      name = element.search(name_css).text.strip
      description = element.search(description_css).text.strip
      difficulty = element.search(difficulty_css).text.strip
      time = element.search(time_css).text.strip

      hash = {
        name: name,
        description: description,
        difficulty: difficulty,
        time: time
      }

      array << hash
    end
    array
  end
end