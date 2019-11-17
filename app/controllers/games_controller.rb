require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @grid = []

    15.times do
      @grid << ("a".."z").to_a.sample(1).join
    end

    @grid
  end

  def score
      @final_score = 0
      @message = "it's not in the grid"
      @attempt_letter = params[:answer].split("")
      @url = "https://wagon-dictionary.herokuapp.com/#{params[:answer].downcase}"
      @array = params[:grid].split("")
      open_web = open(@url).read
      word_verify = JSON.parse(open_web)
      if word_verify["found"] && attempt_word(@attempt_letter, @array)
        @final_score = (params[:answer].length * 6)
        @message = "Well Done!"
      elsif word_verify["error"]
        @message = "not an english word"
      end
    # TODO: runs the game and return detailed hash of result
    @score = { score: @final_score, message: @message }
end


def attempt_word(letter, grid)
  @result = letter.all? do |l|
    if grid.include?(l)
      grid.delete_at(grid.index(l))
      true
    end
  end

    @result
  end
end
