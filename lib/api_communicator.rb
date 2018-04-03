require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get("http://www.swapi.co/api/people/")
  character_hash = JSON.parse(all_characters)
  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  character_hash["results"].find do |person|
    person["name"].downcase == character
  end
  # found_name["films"]  = [url1,url2,url3]
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film

  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end


def get_movie_json (character_movies)
    character_movies["films"].map do |movie|
    response = RestClient.get("#{movie}")
    movie_json = JSON.parse(response)
  end
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  movie_array = []
  films_hash.map do |movie|
    movie_array << movie["title"]
  end

  movie_array.each do |movie|
    puts movie
  end
  movie_array
end

def show_character_movies(character)
  character_movies = get_character_movies_from_api(character)
  films_hash = get_movie_json(character_movies)
  parse_character_movies(films_hash)
end


## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
