require 'spec_helper'

describe 'External request' do
  context 'From ICNDB' do
    uri = URI('https://api.icndb.com/jokes/random')
    let(:response) { Net::HTTP.get_response(uri) }

    it 'queries ICNDB jokes' do
      expect(response.body).to be_an_instance_of(String)
    end
    it 'has a valid response code' do
      expect(response.code).to eq("200")
    end
  end
end
