require 'spec_helper'
require 'json'

describe 'External request' do
  context 'From ICNDB' do
    before(:each) do
      stub_request(:get, /api.icndb.com/).
        with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'api.icndb.com', 'User-Agent'=>'Ruby' }).
        to_return(status: 200, body: {type: 'success', value: {id: 454, joke: "Chuck Norris's first program was kill -9.", categories: ['nerdy']}}.to_json, headers: { 'Content-Type': 'application/json' })
    end

    uri = URI('https://api.icndb.com/jokes/random')
    let(:response) { Net::HTTP.get_response(uri) }

    it 'returns a JSON object' do
      expect(response.body).to be_an_instance_of(String)
    end
    it 'has a valid response code' do
      expect(response.code).to eq("200")
    end
    it 'has a valid id datatype' do
      expect(JSON.parse(response.body)['value']['id']).to be_an Integer
    end
    it 'has a valid id' do
      expect(JSON.parse(response.body)['value']['id']).to eq(454)
    end
    it 'has a valid joke datatype' do
      expect(JSON.parse(response.body)['value']['joke']).to be_a String
    end
    it 'has a valid joke' do
      expect(JSON.parse(response.body)['value']['joke']).to eq("Chuck Norris's first program was kill -9.")
    end
    it 'has a category array' do
      expect(JSON.parse(response.body)['value']['categories']).to be_an Array
    end
    it 'has a valid category' do
      expect(JSON.parse(response.body)['value']['categories'].first).to eq('nerdy')
    end
  end

  context 'Failed ICNDB' do
    before(:each) do
      stub_request(:get, /api.icndb.com/).
        with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
        to_return(status: 500, body: "stubbed response", headers: {})
    end

    uri = URI('https://api.icndb.com/jokes/random')
    let(:response) { Net::HTTP.get_response(uri) }
    let(:joke){ Joke.new(joke: "bunch of stuff", categories: ["nerdy"]) }
    let(:route){ post '/', :From => 4155552200, :Body => "Nerdy" }

    it 'has a valid response code' do
      expect(response.code).to eq("500")
    end
    # it 'defaults to database' do
    #   expect(route).to receive(:read_joke)
    #   route.fetch_joke
    # end
    # it 'successfully retrieves a joke from the databse' do
    #   # expect(route).to receive(:read_joke)
    #   # route.fetch_joke
    # end
  end
end
