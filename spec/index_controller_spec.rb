require 'spec_helper'

describe "ChuckNorrisIDB Controller" do
  context "get /" do
    it "loads homepage" do
      get '/'
      expect(last_response).to be_ok
    end
    it "returns status 200" do
      get '/'
      expect(last_response.status).to eq 200
    end
    it "displays homepage content" do
      get '/'
      expect(last_response.body).to include("Enter your phone number")
    end
  end

  context "post /" do
    it "sends a request" do
      post '/', :From => 4155552200, :Body => "Nerdy"
      expect(last_response.status).to be_ok
    end
    it "redirects back to /" do
      post '/', :From => 4155552200, :Body => "Nerdy"
      expect(last_response.redirect?).to be_true
      follow_redirect!
      expect(last_request.path).to eq('/')
    end
    it "with missing params" do
      post '/'
      expect(last_response.status).to eq 400
    end
  end
end
