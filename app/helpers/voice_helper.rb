# helpers do
#   def boot_twilio
#     account_sid = TWILIO_SID
#     auth_token = TWILIO_TOKEN
#     @client = Twilio::REST::Client.new account_sid, auth_token
#   end
#
#   def gather_number
#     Twilio::TwiML::Response.new do |r|
#       r.Gather :finishOnKey => '#', :timeout => '10', :action => '/voice/forward', :method => 'post' do |g|
#         g.Say 'Dial the number you wish to connect to.'
#         g.Say 'Press pound when finished.'
#       end
#     end.text
#   end
#
#   def forward_call
#     Twilio::TwiML::Response.new do |r|
#       r.Dial :to => "+#{@collected_number}", :from => "SUPER BATMAN"
#     end.text
#     # @call = @client.account.calls.create(
#     # :from => 'SUPER BATMAN',   # From your Twilio number
#     # :to => "+#{@collected_number}",   # To any number
#     # :url => ''
#     # )
#   end
#
#   def failed
#     Twilio::TwiML::Response.new do |r|
#       r.Say 'You are not authoized to connect with this number. Goodbye.'
#     end.text
#   end
# end
