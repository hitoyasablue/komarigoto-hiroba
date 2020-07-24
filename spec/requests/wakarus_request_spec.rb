require 'rails_helper'

RSpec.describe "Wakarus", type: :request do

  describe "GET /create" do
    it "returns http success" do
      get "/wakarus/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/wakarus/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
