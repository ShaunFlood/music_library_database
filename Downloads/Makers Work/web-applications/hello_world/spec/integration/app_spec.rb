require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }
    context "POST /sort-names" do
        it 'returns the names sorted alphabetaically' do
        response = post('/sort-names', name: "Joe,Alice,Zoe,Julia,Kieran")
        expect(response.status).to eq(200)
        expect(response.body).to eq("Alice,Joe,Julia,Kieran,Zoe")
        end
    end
end