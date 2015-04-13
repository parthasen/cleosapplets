require 'rails_helper'

RSpec.describe AppIndexController, :type => :controller do

  describe "GET app" do
    it "returns http success" do
      get :app
      expect(response.status).to eq(200)
    end
  end

end
