require 'spec_helper'

describe 'External request' do
  it 'queries ICNDB jokes' do
    uri = URI('https://api.icndb.com/jokes/random')

    response = Net::HTTP.get(uri)

    expect(response).to be_an_instance_of(String)
  end
end
