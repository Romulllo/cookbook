class Recipe
  attr_reader :name, :description

  def initialize(name, description, prep_time)
    @name = name
    @description = description
  end
end
