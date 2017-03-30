get '/' do
  erb :'chuck'
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
  if params.length == 2
    redirect '/success'
  end
end

get '/success' do
  @message = "Message sent!"
  erb :'chuck'
end
