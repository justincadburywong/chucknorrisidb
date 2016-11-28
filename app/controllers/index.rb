post '/' do
  body = params["Body"]
  p body
  p body.downcase
  if body.downcase.include? 'nerdy'
    p 'nerdy'
    send_nerdy_text
  elsif body.downcase.include? 'dirty'
    p 'dirty'
    send_dirty_text
  else
    p 'normal'
    send_joke_text
  end
end
