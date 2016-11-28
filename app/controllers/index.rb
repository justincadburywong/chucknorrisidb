post '/' do
  if params['body'].downcase.include? 'nerdy' == true
    send_nerdy_text
  elsif params['body'].downcase.include? 'dirty' == true
    send_dirty_text
  else
    send_joke_text
  end
end
