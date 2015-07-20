require "rails_helper"

RSpec.describe UsersController, type: :routing do
  describe "routing" do
    let!(:users_route) { "/users" }
    let!(:user_id) { "1" }
    let!(:user_route) { "#{users_route}/#{user_id}" }

    it "routes to #show" do
      expect(get: user_route).to route_to("users#show", id: user_id)
    end

    it "routes to #create" do
      expect(post: users_route).to route_to("users#create")
    end

    it "routes to #update via PUT" do
      expect(put: user_route).to route_to("users#update", id: user_id)
    end

    it "routes to #update via PATCH" do
      expect(patch: user_route).to route_to("users#update", id: user_id)
    end

    it "routes to #destroy" do
      expect(delete: user_route).to route_to("users#destroy", id: user_id)
    end

  end
end
