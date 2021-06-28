class ScoresController < ApplicationController
    before_action :set_score, only: [:show, :destroy]
    before_action :score_params, only: [:create]

    rescue_from ActionController::ParameterMissing do |e|
        render json: { error: e.original_message }, status: :unprocessable_entity
    end

    has_scope :by_player, only: :index
    #has_scope :time_between, only: :index
    has_scope :after_date, only: :index
    has_scope :before_date, only: :index

    # GET /scores
    def index
        @scores = apply_scopes(Score).all
        paginate json: @scores, per_page: 10
    end

    # GET /scores/:id
    def show
        json_response(@score)
    end

    # POST /scores
    def create
        #puts score_params
        #puts params[:player][:name]
        @player = Player.where(name: params[:player][:name]).first_or_create 
        #puts @player
        @score = @player.scores.create!(score_params)
        #puts @score
        json_response(@score, :created)
    end

    # DELETE /scores/:id
    def destroy
        @score.destroy
        head :no_content
    end

    private

    def score_params
        # Whitelist parameters
        params.require(:player).permit(:name)
        params.permit(:score, :time)
    end

    def set_score
        @score = Score.find(params[:id])
    end
end
