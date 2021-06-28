require 'rails_helper'

RSpec.describe "Players", type: :request do

  let!(:players) { create_list(:player, 10) }
  let(:player) { players.first }
  let(:player_id) { players.first.id }
  let(:player2) { players.second }
  let(:player2_id) { players.second.id }

  before(:each) do
    @score1 = Score.create(player: player, score: 10, time: '2021-06-27')
    @score2 = Score.create(player: player, score: 100, time: '2021-04-20')
  end

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

      it 'returns player history with top/low/avg and scores list when scores exist' do
        expect(json['top_score']).to eq(100)
        expect(json['low_score']).to eq(10)
        expect(json['avg_score']).to eq("55.0")
        expect(json['all_score']).not_to be_empty
      end
    end

    context 'when the record exist but scores do not' do
      let(:player_id) { player2_id }
      it 'returns player history without top/low/avg and scores list' do
        expect(json['top_score']).to be_nil
        expect(json['low_score']).to be_nil
        expect(json['avg_score']).to be_nil
        expect(json['all_score']).to be_empty
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
