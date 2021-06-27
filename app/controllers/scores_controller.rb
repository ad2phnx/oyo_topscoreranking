class ScoresController < ApplicationController
    before_action :set_score, only: [:show, :destroy]

    #rescue_from ActionController::ParameterMissing do |e|
    #    render json: { error: e.message }, status: :bad_request
    #end

    # GET /scores
    def index
        @scores = Score.all
        json_response(@scores)
    end

    # GET /scores/:id
    def show
        json_response(@score)
    end

    # POST /scores
    def create
        @player = Player.where(name: params[:name]).first_or_create 
        puts @player
        @score = @player.scores.create!(score_params)
        puts @score
        json_response(@score, :created)
    end

    private

    def score_params
        # Whitelist parameters
        params.permit(:score, :time)
    end

    def set_score
        @score = Score.find(params[:id])
    end
end
