# post '/voice' do
#   p params
#   if params['From'] == '+14158459551'
#     # answer the call
#     gather_number  # ask for phone number
#   else
#     # answer the call
#     redirect '/voice/failed'
#   end
# end
#
# get '/voice/failed' do
#   failed
# end
#
# post '/voice/forward' do
#   p params
#   @collected_number = params['Digits']
#   forward_call
# end
