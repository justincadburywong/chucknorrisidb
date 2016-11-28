post '/' do
  if params[:body].downcase == 'nerdy'
    send_nerdy_text
  elsif params[:body].downcase == 'dirty'
    send_dirty_text
  else
    send_joke_text
  end
end
