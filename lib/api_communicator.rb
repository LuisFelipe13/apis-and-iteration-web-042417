require 'rest-client'
require 'json'
require 'pry'

# iterate over the character hash to find the collection of `films` for the given
#   `character`
# collect those film API urls, make a web request to each URL to get the info
#  for that film
# return value of this method should be collection of info about each film.
#  i.e. an array of hashes in which each hash reps a given film
# this collection will be the argument given to `parse_character_movies`
#  and that method will do some nice presentation stuff: puts out a list
#  of movies by title. play around with puts out other info about a given film.

def get_character_movies_from_api(character)
  #make the web request
  characters_url = []
  result = []
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  character_hash.each do |key, value|
    if key == "results"
      value.each do |keys|
        keys.each do |stats, info|
          if stats == "url"
            characters_url << character_hash["results"][0]["url"]
          end
        end
      end
    end
  end

  titles = RestClient.get('http://www.swapi.co/api/films/')
  titles_hash = JSON.parse(titles)
  titles_hash.each do |key, value|
  x = 0
    if key == "results"
      value.each do |keys|
        keys.each do |stats, info|
          if stats == "characters"
            info.each do |people|
              if people == characters_url[0]
                result << titles_hash["results"][x]["title"]
                x += 1
              end
            end
          end
        end
      end
    end
  end
  result
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.each_with_index do |film, index|
    puts "#{index + 1} #{film}"
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

# get_character_movies_from_api("Luke Skywalker")
# show_character_movies("Luke Skywalker")

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
# binding.pry
