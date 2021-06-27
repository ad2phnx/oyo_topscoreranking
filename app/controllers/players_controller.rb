class PlayersController < ApplicationController
    before_action :set_player, only: [:show]

    # Get /players/:id
    def show
        json_response(@player)
    end

    private

    def set_player
        @player = Player.find(params[:id])
    end
end
