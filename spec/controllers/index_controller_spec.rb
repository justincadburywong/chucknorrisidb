require 'spec_helper'
require 'json'

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
    it "displays the correct path" do
      get '/'
      expect(last_request.path).to eq('/')
    end
    it "displays homepage content" do
      get '/'
      expect(last_response.body).to include("Enter your phone number")
    end
  end

  # context "post /" do
  #   it "sends a request" do
  #     post '/', :From => 4155552200, :Body => "Nerdy"
  #     expect(last_response.status).to be_ok
  #   end
  #   it "redirects back to /success" do
  #     post '/', :From => 4155552200, :Body => "Nerdy"
  #     expect(last_response.redirect?).to be true
  #     follow_redirect!
  #     expect(last_request.path).to eq('/success')
  #   end
  # end

  context "post / with missing params" do
    it "returns status 302" do
      post '/', :Body => "Nerdy"
      expect(last_response.status).to eq 302
    end
    it "redirects to /fail" do
      post '/', :Body => "Nerdy"
      expect(last_response.redirect?).to be true
      follow_redirect!
      expect(last_request.path).to eq('/fail')
    end
  end

  context "get /success" do
  end

  context "get /fail" do
  end
end
