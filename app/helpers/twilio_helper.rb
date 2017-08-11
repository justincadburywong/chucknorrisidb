require 'net/http'
require 'json'

helpers do
  def boot_twilio
    account_sid = TWILIO_SID
    auth_token = TWILIO_TOKEN
    @twilio_number = TWILIO_NUMBER
    @client = Twilio::REST::Client.new account_sid, auth_token
    @from_number = params["From"]
  end

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

  def send_message
    @client.account.messages.create(
      :from => @twilio_number,
      :to => @from_number,
      :body => clean_message
      )
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

  def send_nerdy_text
    @url = 'http://api.icndb.com/jokes/random?limitTo=[nerdy]'
    boot_twilio
    send_message
  end

  def send_dirty_text
    @url = 'http://api.icndb.com/jokes/random?limitTo=[explicit]'
    boot_twilio
    send_message
  end

  def send_joke_text
    @url = 'http://api.icndb.com/jokes/random?exclude=[explicit]'
    boot_twilio
    send_message
  end

end
