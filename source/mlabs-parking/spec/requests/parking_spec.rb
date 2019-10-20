require 'rails_helper'

RSpec.describe 'Parking API', type: :request do
    # initialize test data 
    let!(:parking) { create_list(:parking, 8) }
    let(:parking_id) { parking.first.id }
    let(:parking_plate) { parking.first.plate }
    let(:parking_paid_id) { 1 }
    let(:parking_not_paid_id) { 2 }
    
    before :all do
        puts "-- Alerta --"
        @parkings = create_list(:parking, 2)

        parking_paid = Parking.find(1)
        parking_paid.paid = true
        parking_paid.save
        
        parking_not_paid = Parking.find(2)
        parking_not_paid.paid = false
        parking_not_paid.save

    end


    # Test suite for GET /parking
    describe 'GET /parking' do
        # make HTTP get request before each example
        before { get '/parking' }
        it 'returns parking car\'s' do
            expect(json).not_to be_empty
            expect(json.size).to eq(10)
        end

        it 'returns status code 200' do
            expect(response).to have_http_status(200)
        end
    end

    # Test suite for GET /parking/:id
    describe 'GET /parking/:plate' do
    
        before { get "/parking/#{parking_plate}/" }
        context 'when the record exists' do
            it 'returns events of the parking car\'s' do
                expect(json).not_to be_empty
            end
    
            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end
        end
    
        context 'when the record does not exist' do
            let(:parking_plate) { 'XXX-9999' }
      
            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end
      
            it 'returns a not found message' do
                expect(response.body).to match(/plate not found/)
            end
        end
    
    end

    # Test suite for GET /parking/:parking_id/pay
    describe 'GET /parking/:parking_id/pay' do

        before { get "/parking/#{parking_id}/pay" }
        context 'when the parking has paid' do
            let(:parking_id) { 2 }
            it 'returns the parking car\'s' do
                expect(json).not_to be_empty
                expect(json['id']).to eq(parking_id)
            end
    
            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end
        end

        context 'when the record does not exist' do
            let(:parking_id) { 100 }
      
            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end
      
            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Parking/)
            end
        end

    end

    # Test suite for GET /parking/:parking_id/out for paid
    describe 'GET /parking/:parking_id/out' do

        before { get "/parking/#{parking_paid_id}/out" }
        context 'when a car have pay' do
            # let(:parking_id) { 1 }
            it 'returns the parking car\'s' do
                expect(json).not_to be_empty
                expect(json['id']).to eq(parking_paid_id)
            end
    
            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end
        end
    end

    # Test suite for GET /parking/:parking_id/out for not paid
    describe 'GET /parking/:parking_id/out' do
        before { get "/parking/#{parking_not_paid_id}/out" }
        context 'when don\'t have pay' do

            it 'returns status code 402' do
                expect(response).to have_http_status(402)
            end

            it 'returns a Payment Required message' do
                expect(response.body).to match(/payment required/)
            end
        end

        context 'when the record does not exist' do
            let(:parking_not_paid_id) { 100 }
      
            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end
      
            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Parking/)
            end
        end

    end

end