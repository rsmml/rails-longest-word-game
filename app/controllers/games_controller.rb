require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = generate_grid
  end

  def generate_letter
    ('A'..'Z').to_a.sample
  end

  def generate_grid
    grid_array = []
    grid_array.push(generate_letter) while grid_array.count < 10
    grid_array
  end

  def included?
    @word.chars.sort.all? do |letter|
      @word.count(letter) <= @grid.count(letter)
    end
  end

  def english_word?
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    word_dictionary = open(url).read
    word = JSON.parse(word_dictionary)
    word['found']
  end

  def score
    # raise
    @grid = params[:grid]
    @word = params[:word].upcase

    grid_letters = @grid.each_char { |letter| print letter, '' }

    included? ?
      english_word? ?
        @result = "Woohoo! #{@word} is a valid English word." :
        @result = "Sorry but #{@word} is not an English word."
      : @result = "Sorry, but #{@word} can’t be built out of #{grid_letters}."
  end
end
