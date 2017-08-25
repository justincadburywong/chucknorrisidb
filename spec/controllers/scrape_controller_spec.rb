
  require 'spec_helper'

  describe "Scrape Controller" do
    context "get /scrape" do
      it "loads scrape page" do
        get '/scrape'
        expect(last_response).to be_ok
      end
      it "returns status 200" do
        get '/scrape'
        expect(last_response.status).to eq 200
      end
      it "displays the correct path" do
        get '/scrape'
        expect(last_request.path).to eq('/scrape')
      end
      it "displays scrape content" do
        get '/scrape'
        expect(last_response.body).to include("This button saves any new jokes to the local database.")
      end
    end

    context "post /scrape" do
      before(:each) do
        stub_request(:get, /api.icndb.com/).
          with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'api.icndb.com', 'User-Agent'=>'Ruby' }).
          to_return(status: 200, body: {type: 'success', value: {id: 454, joke: "Chuck Norris's first program was kill -9.", categories: ['nerdy']}}.to_json, headers: { 'Content-Type': 'application/json' })
      end
      it "sends a request" do
        post '/scrape'
        expect(last_response.status).to eq 302
      end
      it "redirects back to /scrape_success" do
        post '/scrape'
        expect(last_response.redirect?).to be true
        follow_redirect!
        expect(last_request.path).to eq('/scrape_success')
      end
      # it reaches out to the icndb
      # it saves new data to the db
      # it does not save data if it exists
    end


    context "get /scrape_success" do
      it "loads scrape page" do
        get '/scrape_success'
        expect(last_response).to be_ok
      end
      it "returns status 200" do
        get '/scrape_success'
        expect(last_response.status).to eq 200
      end
      it "displays scrape success message" do
        get '/scrape_success'
        expect(last_response.body).to include("Scrape succeeded!")
      end
    end

  end
