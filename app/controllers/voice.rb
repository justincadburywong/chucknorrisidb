post '/voice' do
  p params
  if params['From'] == '+14158459551'
    gather_number  # ask for phone number
  else
    redirect '/voice/failed'
  end
end

get '/voice/failed' do
  failed
end

post '/voice/forward' do
  p params
  @collected_number = params['digits'] - '#'
  forward_call
end
