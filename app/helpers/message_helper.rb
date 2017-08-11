require 'net/http'
require 'json'

helpers do
  def save_message(response)
    if !Joke.find_by(joke: response['joke'])
      Joke.create(joke: response['value']['joke'], categories: response['value']['categories'])
    end
  end

  def get_message
    uri = URI(@url)
    response = Net::HTTP.get(uri)
    parsed = JSON.parse(response)
  end

  def clean_message
    joke = get_message['value']['joke'] || Joke.rand()
    clean_response = joke.gsub("&quot;", "'")
  end

  def scrape_api
    counter = 1
    700.times do
      @url = "http://api.icndb.com/jokes/#{counter}"
      response = get_message
      if response['type'] == "success"
        save_message(response)
      end
      counter +=1
    end
  end
end
