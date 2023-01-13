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
      it 'should create a new artist' do 
        response = post('artist',
        name: 'Wild nothing',
        genre: 'Indie')
        expect(response.status).to eq(200)
        expect(response.body).to eq ('')

        response = get('artist')
        expect(response.body).to include('Wild nothing')
      end 
    end 

    context 'GET /artists' do 
      it 'should return a list of artist, which hyperlinks to their individual page' do
        response = get('/artists')
        expect(response.status).to eq(200)
        expect(response.body).to include('<a href="/artists/1">Pixies</a><br />')
        expect(response.body).to include('<a href="/artists/2">ABBA</a><br />')
        expect(response.body).to include('<a href="/artists/3">Taylor Swift</a><br />')
        expect(response.body).to include('<a href="/artists/4">Nina Simone</a><br />')
      end
    end
    context 'get /artists/:id' do
      it 'should return a page with the relevant artist based upon inputted id, /artist/1 = pixies etc' do
        response = get('/artists/1')
        expect(response.status).to eq(200)
        expect(response.body).to include('<h1>Pixies</h1>')
        expect(response.body).to include('Genre: Rock')
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