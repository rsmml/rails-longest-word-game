class GamesController < ApplicationController
  def new
    @letters = generate_grid
  end

  def score
  end

  def generate_letter
    ('A'..'Z').to_a.sample
  end

  def generate_grid
    grid_array = []
    grid_array.push(generate_letter) while grid_array.count < 10
    grid_array
  end
end
