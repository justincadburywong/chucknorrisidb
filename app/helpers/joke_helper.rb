require 'net/http'
require 'json'

helpers do
  def read_joke
    Joke.order("RANDOM()").first.joke
  end

  def clean_joke(string)
    string.gsub("&quot;", "'")
  end

  def fetch_joke
    uri = URI(@url)
    response = Net::HTTP.get_response(uri)
    if response.code == "200"
      joke = JSON.parse(response.body)['value']['joke']
      return clean_joke(joke)
    else
      clean_joke(read_joke)
    end
  end

  # As a contingency to back up all of the jokes
  def save_joke(response)
    if !Joke.find_by(joke: response['joke'])
      Joke.create(joke: response['value']['joke'], categories: response['value']['categories'])
    end
  end

  def scrape_api
    counter = 1
    700.times do
      @url = "http://api.icndb.com/jokes/#{counter}"
      uri = URI(@url)
      response = Net::HTTP.get_response(uri)
      if JSON.parse(response.body)['type'] == "success"
        save_joke(JSON.parse(response.body))
      end
      counter +=1
    end
  end
end
