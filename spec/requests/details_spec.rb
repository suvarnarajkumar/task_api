# spec/requests/details_spec.rb
require 'rails_helper'

RSpec.describe 'Task API', type: :request do
  
  # initialize test data 
  let!(:details) { Detail.all }
  let(:detail_id) { details.first.id }

  # Test suite for GET /details
  describe 'GET /details' do
    before { get '/details' }

    it 'returns details' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /details/:id
  describe 'GET /details/:id' do
    before { get "/details/#{detail_id}" }

    context 'when the record exists' do
      it 'returns the detail' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(detail_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:detail_id) { 1000 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Detail/)
      end
    end
  end

  # Test suite for POST /details
  describe 'POST /details' do

    let(:valid_attributes) { { street: "5828 PEPPERMILL CT", city: "SACRAMENTO", zip: 95841, state: "CA", beds: 3, baths: 1, sq__ft: 1122, building_type: "Condo", sale_date: "2008-05-21T04:00:00.000Z", price: 89921, latitude: "38.662595", longitude: "-121.327813" } }

    context 'create new record' do
      before { post '/details', params: valid_attributes }

      it 'creates a detail' do
        expect(json['zip']).to eq(95841)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

  end

  # Test suite for PUT /details/:id
  describe 'PUT /details/:id' do
    let(:valid_attributes) { { zip: 12345 } }

    context 'update the existing record' do
      before { put "/details/#{detail_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /details/:id
  describe 'DELETE /details/:id' do
    before { delete "/details/#{detail_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end

  # Test suite for GET /details?page=2 for pagination
  describe 'GET /details?page=2' do
    before { get '/details?page=2' }
    
    it 'return page 2 details' do
      expect(json).not_to be_empty
      expect(json.first['id']).to eq(11)
      expect(json.size).to be <= 10
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /details?beds_range=4-2&page=1&sq__ft_range=1000-1200&building_type=condo for pagination and search
  describe 'GET /details?beds_range=4-2&page=1&sq__ft_range=1000-1200&building_type=condo' do
    
    context 'checking for correct inputs parameters for search' do
      before { get '/details?beds_range=4-2&page=1&sq__ft_range=1000-1200&building_type=condo' }

      it 'return search details' do
        expect(json).not_to be_empty
        expect(json.first['beds']).to be <= 4
        expect(json.first['beds']).to be >= 2
        expect(json.first['sq__ft']).to be <= 1200
        expect(json.first['sq__ft']).to be >= 1000
        expect(json.first['building_type'].downcase).to eq('condo') 
        expect(json.size).to be <= 10
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    
    end

    context 'checking for wrong inputs parameters for search' do
      before { get '/details?beds_range=sds&page=1&sq__ft_range=sdsf&building_type=condo' }
      it 'return search details' do
        expect(json).not_to be_empty
        expect(json.first).to eq('Please check beds & sq__ft range search value passed.')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

  end

end