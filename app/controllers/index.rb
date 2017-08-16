get '/' do
  erb :'index'
end

post '/' do
  body = params["Body"]
  p params
  if body.downcase.include? 'nerdy'
    send_nerdy_text
  elsif body.downcase.include? 'dirty'
    send_dirty_text
  else
    send_joke_text
  end

  # if using the web interface
  if params.length == 2
    redirect '/success'
  end
end

get '/success' do
  @message = "Message sent!"
  erb :'index'
end

get '/fail' do
  @message = "Try again, you missed something"
  erb :'index'
end
