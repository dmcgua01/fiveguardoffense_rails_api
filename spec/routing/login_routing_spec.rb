require "rails_helper"

RSpec.describe LoginController, type: :routing do
  describe "routing" do
    let!(:login_route) { "/login" }
    let!(:login_controller) { "login#login" }

    it "routes to #login" do
      expect(post: login_route).to route_to(login_controller)
    end

  end
end
