require 'net/http'
require 'json'

helpers do
  def read_joke(category)
    # Joke.order("RANDOM()").first.joke  # is slow
    # Joke.offset(rand(Joke.count)).first.joke # is better/faster
    # Joke.where('categories LIKE ?', '%' + "#{category}" + '%').order("random()").first.joke
    Joke.where('categories LIKE ?', '%' + "#{category}" + '%').offset(rand(Joke.where('categories LIKE ?', '%' + "#{category}" + '%').count)).first.joke
  end

  def clean_joke(string)
    string.gsub("&quot;", "'")
  end

  def fetch_joke
    uri = URI(@url)
    response = Net::HTTP.get_response(uri)
    if response.code == "200"
      joke = JSON.parse(response.body)['value']['joke']
      p joke
      return clean_joke(joke)
    else
      clean_joke(read_joke(params[:Body]))
    end
  end

  def fetch_dad_joke
    uri = URI(@url)
    req = Net::HTTP::Get.new(uri)
    req['accept'] = 'text/plain'
    req['user-agent'] = 'github.com/justincadburywong/chucknorrisidb'

    response = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => true) {|http|
      http.request(req)
    }

    if response.code == "200"
      p response.body
      return response.body
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
    100.times do
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
