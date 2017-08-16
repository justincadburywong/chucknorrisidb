
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
        expect(last_response.body).to include("All this button does is add any new jokes to the local database.")
      end
    end

    # context "post /scrape" do
    #   it "sends a request" do
    #     post '/', :From => 4155552200, :Body => "Nerdy"
    #     expect(last_response.status).to be_ok
    #   end
    #   it "redirects back to /" do
    #     post '/', :From => 4155552200, :Body => "Nerdy"
    #     expect(last_response.redirect?).to be_true
    #     follow_redirect!
    #     expect(last_request.path).to eq('/scrape')
    #   end
    #   it "with missing params" do
    #     post '/'
    #     expect(last_response.status).to eq 400
    #   end
    # end


    context "get /scrape_success" do
      it "loads scrape page" do
        get '/scrape'
        expect(last_response).to be_ok
      end
      it "returns status 200" do
        get '/scrape'
        expect(last_response.status).to eq 200
      end
    end

  end
