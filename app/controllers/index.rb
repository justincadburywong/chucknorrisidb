post '/' do
  p params["Body"]
  if params['Body'].downcase.include? 'nerdy' == true
    send_nerdy_text
  elsif params['Body'].downcase.include? 'dirty' == true
    send_dirty_text
  else
    send_joke_text
  end
end
