require 'net/http'
require 'json'

helpers do
  def boot_twilio
    account_sid = TWILIO_SID
    auth_token = TWILIO_TOKEN
    @twilio_number = TWILIO_NUMBER
    @client = Twilio::REST::Client.new account_sid, auth_token
    @from_number = params["From"].split(",")
  end

  def send_message
    uri = URI(@url)
    response = Net::HTTP.get(uri)
    @from_number.each do |number|
    @client.account.messages.create(
      :from => @twilio_number,
      :to => number,
      :body => JSON.parse(response)['value']['joke']
      )
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
