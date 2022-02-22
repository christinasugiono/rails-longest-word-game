require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @word = params[:word].upcase
    @grid = params[:grid].split
    @letters_of_word = @word.split('')
    @check_letter = true
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    dictionary_serialized = URI.open(url).read
    dictionary = JSON.parse(dictionary_serialized)

    @letters_of_word.each do |letter|
      if !(@grid.include?(letter))
        @check_letter = false
        return @result = "Sorry but #{@word} can't be built out of #{@grid}"
      end
    end

    if dictionary["found"]
      return @result = "Congratulations! #{@word} is a valid English word!"
    else
      return @result = "Sorry but #{@word} does not seem to be a valid English word..."
    end
  end
end
