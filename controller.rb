require_relative 'view'
require 'nokogiri'
require 'open-uri'

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

  def import_recipes
    #pergunta o que quer pesquisar
    recipe = @view.what_scraper
    #pesquisa o item
    scrape_recipes = scrape(recipe)
    #mostra os itens pesquisados
    @view.display_scrape(scrape_recipes)
    #pergunta qual quer adicionar
    index = @view.ask_for_add_scrape
    #Adiciona na lista de receita
    add_recipe = scrape_recipes[index]

    new_recipe = Recipe.new(add_recipe[:title], add_recipe[:description])
    @cookbook.add_recipe(new_recipe)
  end

  def destroy
    # ask the user for an index to destroy
    index = @view.ask_for('index').to_i - 1
    @cookbook.remove_recipe(index)
  end

  private

  def scrape(recipe)
  url = "https://www.bbcgoodfood.com/search/recipes?query=#{recipe}"
  # url = "https://lista.mercadolivre.com.br/#{recipe}"

  html_content = open(url).read
  html_doc = Nokogiri::HTML(html_content)

  parent_css_pattern = 'div.view-content > article.node.node-recipe.node-teaser-item.clearfix'
  title_css_pattern = 'h3.teaser-item__title > a'
  description_css_pattern = 'div.field-items'
  # css_pattern = '.item__info h2 .main-title'

  items = []
  html_doc.search(parent_css_pattern).first(5).each do |element|
    title = element.search(title_css_pattern).text.strip
    description = element.search(description_css_pattern).text.strip
    items << { title: title, description: description}
    end
  items
  end
end
