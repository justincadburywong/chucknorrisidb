get '/scrape' do
  erb :'scrape'
end

post '/scrape' do
  scrape_api
  redirect '/scrape_success'
end

get '/scrape_success' do
  @message = "Scrape succeeded!"
  erb :'scrape'
end
