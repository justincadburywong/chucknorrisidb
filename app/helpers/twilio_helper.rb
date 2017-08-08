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

  def save_message(message)
    bulk = JSON.parse(message)['value']
    id = bulk['id'].to_i
    if !Joke.find_by(number: id)
      Joke.create(number: bulk['id'], joke: bulk['joke'], categories: bulk['categories'])
    end
  end

  def get_message
    uri = URI(@url)
    response = Net::HTTP.get(uri)
    save_message(response)
    return response
  end

  def clean_message
    joke = JSON.parse(get_message)['value']['joke']
    clean_response = joke.gsub("&quot;", "'")
  end

  def send_message
    @client.account.messages.create(
      :from => @twilio_number,
      :to => @from_number,
      :body => clean_message
      )
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
