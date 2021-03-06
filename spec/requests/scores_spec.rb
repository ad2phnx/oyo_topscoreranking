require 'rails_helper'

RSpec.describe "Scores", type: :request do

  # Init test data
  let!(:player1) { create(:player) }
  let!(:scores1) { create_list(:score, 19, player_id: player1.id) }
  let(:player1_id) { player1.id }
  let(:id1) { scores1.first.id }

  describe 'GET /scores' do
    before { get "/scores" }

    it 'return status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns first page (10) scores' do
      expect(json.size).to eq(10)
    end
  end

  describe 'GET /scores?page=2' do
    before { get "/scores?page=2" }

    it 'return status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns rest of scores' do
      expect(json.size).to eq(9)
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
    let(:valid_attributes) { { player: { name: 'John Smith'}, score: 45, time: '01-01-2021' } }
    let(:invalid_date_attribute) { { player: { name: 'John Smith'}, score: 45, time: '014.0133.20213' } }
    let(:invalid_score_attribute) { { player: { name: 'John Smith'}, score: 0, time: '01-01-2021' } }

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

    context 'zero score validation' do
      before { post "/scores", params: invalid_score_attribute }

      it 'returns status code 421' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to include_json(
          message: "Validation failed: Score must be greater than 0"
        )
      end
    end

    context 'when wrong date format' do
      before { post "/scores", params: invalid_date_attribute }

      it 'returns status code 421' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to include_json(
          message: "Validation failed: Time can't be blank, Time is invalid"
        )
      end
    end
  end

  describe 'DELETE /scores/:id' do
    before { delete "/scores/#{id1}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
