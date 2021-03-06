
helpers do
  def boot_twilio
    account_sid = TWILIO_SID
    auth_token = TWILIO_TOKEN
    @twilio_number = TWILIO_NUMBER
    @client = Twilio::REST::Client.new(account_sid, auth_token)
    @from_number = params["From"]
  end

  def send_message
    @client.messages.create(
      :from => @twilio_number,
      :to => @from_number,
      :body => fetch_joke
    )
  end

  def send_dad_message
    @client.messages.create(
      :from => @twilio_number,
      :to => @from_number,
      :body => fetch_dad_joke
    )
  end

  def send_dad_text
    @url = 'https://icanhazdadjoke.com'
    boot_twilio
    send_dad_message
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
