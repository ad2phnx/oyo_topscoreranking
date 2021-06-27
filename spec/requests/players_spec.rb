require 'rails_helper'

RSpec.describe "Players", type: :request do

  let!(:players) { create_list(:player, 10) }
  let(:player_id) { players.first.id }

  # Test GET /players/:player_id
  describe 'GET /players/:id' do
    before { get "/players/#{player_id}" }

    context 'when the record exists' do
      it 'returns the player' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(player_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:player_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Player/)
      end
    end
  end
end
