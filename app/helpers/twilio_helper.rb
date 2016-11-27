require 'net/http'
require 'json'

def boot_twilio
  account_sid = TWILIO_SID
  auth_token = TWILIO_TOKEN
  @twilio_number = TWILIO_NUMBER
  @client = Twilio::REST::Client.new account_sid, auth_token
  @from_number = params["From"]
end

def send_joke_text
  url = 'http://api.icndb.com/jokes/random?exclude=[explicit]'
  uri = URI(url)
  response = Net::HTTP.get(uri)
  boot_twilio
  @client.account.messages.create(
    :from => @twilio_number,
    :to => @from_number,
    :body => JSON.parse(response)['value']['joke']
    )
end
