
require 'rest-client'
require 'json'
require 'pry'



def get_character_movies_from_api(character)
# Requests a list of all characters from starwars API and returns all info on given charcter
  character_hash = []
  continue = true
  count = 0
  while count < 9
    count += 1
    all_characters = RestClient.get("http://www.swapi.co/api/people/?page=#{count}")
    current_page_hash = JSON.parse(all_characters)
    character_hash << current_page_hash
  end
  character_hash.each_with_index do |page, index|
    character_hash[index]["results"].each do |person|
      if person["name"].downcase == character
       return person
      end
    end
  end
end




def get_movie_json (character_movies)
  #takes character info and finds requests all info on movies in which the charater appears
  character_movies["films"].map do |movie|
    response = RestClient.get("#{movie}")
    movie_json = JSON.parse(response)
  end
end

def parse_character_movies(films_hash)
  #Take array of movie(s) info, returns an array of titles, and prints them
  movie_array = []
  films_hash.map do |movie|
    movie_array << movie["title"]
  end
  movie_array.each do |movie|
    puts movie
  end
end

def show_character_movies(character)
  character_movies = get_character_movies_from_api(character)
  films_hash = get_movie_json(character_movies)
  parse_character_movies(films_hash)
end


## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
