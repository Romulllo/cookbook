class Recipe
  attr_reader :name, :description, :prep_time, :difficulty

  def initialize(name, description, prep_time = nil, difficulty = nil)
    @name = name
    @description = description
    @prep_time = prep_time if prep_time
    @difficulty = difficulty if difficulty
  end
end