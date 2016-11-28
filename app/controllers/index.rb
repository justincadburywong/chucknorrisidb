post '/' do
  if params[:body] = 'nerdy'
    send_nerdy_text
  elsif params[:body = 'dirty']
    send_dirty_text
  else
    send_joke_text
  end
end
