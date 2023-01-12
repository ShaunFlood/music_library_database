require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }
    context "POST /albums" do
      it 'should create a new album' do
        response = post('/albums', 
        title: 'Voyage', 
        release_year: '2022',
        artist_id: '2'
        )
        expect(response.status).to eq(200)
        expect(response.body).to eq ('')
        
        response = get('albums')
        expect(response.body).to include('Voyage')
      end
    end
    context 'GET /artist' do
      it 'should display a list of artists' do 
        response = get('artist')
        expect(response.status).to eq(200)
        expect(response.body).to eq "Pixies, ABBA, Taylor Swift, Nina Simone"
      end 
    end 
    context 'POST /artist' do 
      it 'it should create a new artist' do 
        response = post('artist',
        name: 'Wild nothing',
        genre: 'Indie')
        expect(response.status).to eq(200)
        expect(response.body).to eq ('')

        response = get('artist')
        expect(response.body).to include('Wild nothing')
      end 
    end 
   
    # Request:
#GET /artists

# Expected response (200 OK)
#Pixies, ABBA, Taylor Swift, Nina Simone



# Request:
#POST /artists
# With body parameters:
#name=Wild nothing
#genre=Indie
# Expected response (200 OK)
#(No content)

# Then subsequent request:
#GET /artists

# Expected response (200 OK)
#Pixies, ABBA, Taylor Swift, Nina Simone, Wild nothing

#test to do here 
end