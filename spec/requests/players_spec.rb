require 'rails_helper'

RSpec.describe "Players", type: :request do

  let!(:players) { create_list(:player, 10) }
  let(:player) { players.first }
  let(:player_id) { players.first.id }
  let(:score1) { Score.create(player, score: 10, time: '2021-01-01')}
  let(:score2) { Score.create(player, score: 100, time: '2021-04-20')}

  # GET /players
  describe 'GET /players' do
    before { get "/players" }

    it 'returns players' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test GET /players/:player_id
  describe 'GET /players/:id' do
    before { get "/players/#{player_id}" }

    context 'when the record exists' do
      it 'returns the player' do
        expect(json).not_to be_empty
        expect(json['player']['id']).to eq(player_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns player history' do
        puts json
        expect(json['top_score']).not_to be_empty
        expect(json['low_score']).not_to be_empty
        expect(json['avg_score']).not_to be_empty
        expect(json['all_score']).not_to be_empty
      end
    end

    context 'when the record does not exist' do
      let(:player_id) { 10000 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Player/)
      end
    end
  end
end
