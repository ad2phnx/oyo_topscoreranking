require 'rails_helper'

RSpec.describe "Healths", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/health/index"

      expect(response.body).to eq('{"status":"online"}')

      expect(response.status).to eq(200)
    end
  end

end
