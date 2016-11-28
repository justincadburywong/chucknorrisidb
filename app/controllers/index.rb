post '/' do
  body = params["Body"]
  if body.downcase.include? 'nerdy'
    send_nerdy_text
  elsif body.downcase.include? 'dirty'
    send_dirty_text
  else
    send_joke_text
  end
end
