class PlayersController < ApplicationController
    before_action :set_player, only: [:show]

    # Get /players
    def index
        json_response(Player.all)
    end

    # Get /players/:id
    def show
        @history = {
            player: @player,
            top_score: @player.top_score,
            low_score: @player.low_score,
            avg_score: @player.average_score,
            all_score: @player.scores.select(:score, :time).as_json(:except => :id)
        }
        json_response(@history)
    end

    private

    def set_player
        @player = Player.find(params[:id])
    end
end
