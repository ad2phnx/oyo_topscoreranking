require 'rails_helper'

RSpec.describe "Scores", type: :request do

  # Init test data
  let!(:player1) { create(:player) }
  let!(:scores1) { create_list(:score, 20, player_id: player1.id) }
  let(:player1_id) { player1.id }
  let(:id1) { scores1.first.id }

  describe 'GET /scores' do
    before { get "/scores" }

    it 'return status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns all scores' do
      expect(json.size).to eq(20)
    end
  end

  describe 'GET /scores/:id' do
    before { get "/scores/#{id1}" }

    context 'when record exists' do
      it 'returns the score' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(id1)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when record does not exist' do
      let(:id1) { 10000 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Score/)
      end
    end
  end

  describe 'POST /scores' do
    let(:valid_attributes) { { player: { name: 'John Smith'}, score: 45, time: 'January 1, 2021' } }

    context 'when request attributes are valid' do
      before { post "/scores", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/scores", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to include_json(
          error: 'param is missing or the value is empty: player'
        )
      end
    end
  end
end
