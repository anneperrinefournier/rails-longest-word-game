require 'open-uri'

class GamesController < ApplicationController

  def new
   @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @letters_words = params["word"].upcase.split
    @letters = params["letters"].delete(' ')
    @all_letters_include = @letters_words.all? { |letter| @letters.include?(letter) }
    url = "https://wagon-dictionary.herokuapp.com/#{params["word"]}"
    res_serialized = URI.open(url).read
    res = JSON.parse(res_serialized)

    # res["found"] == true
    # res["word"] include letters
    # res["word"].chars.all? { |letter| @letters.includes(letter) }

      if @all_letters_include && res["found"] == true
        @result = "Great!"
      elsif @all_letters_include && @url_word == false
        @result = "Sorry, but #{params["word"]} does not seem to be a valid English word…"
      elsif @url_word && @all_letters_include == false
        @result = "Sorry, but #{params["word"]} can't be build out of #{@letters.split}."
      else
        @result = "Sorry, but #{params["word"]} does not seem to be a valid English word. And #{params["word"]} can't be build out of #{@letters.split}."
      end
  end
end
