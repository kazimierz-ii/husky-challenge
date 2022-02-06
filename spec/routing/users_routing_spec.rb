require "rails_helper"

RSpec.describe UsersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/users").to_not be_routable
    end

    it "routes to #new" do
      expect(get: "/users/new").to_not be_routable
    end

    it "routes to #show" do
      expect(get: "/users/1").to_not be_routable
    end

    it "routes to #edit" do
      expect(get: "/users/1/edit").to_not be_routable
    end

    it "routes to #create" do
      expect(post: "/users").to route_to("users#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/users/1").to_not be_routable
    end

    it "routes to #update via PATCH" do
      expect(patch: "/users/1").to_not be_routable
    end

    it "routes to #destroy" do
      expect(delete: "/users/1").to_not be_routable
    end

    it "routes to #logout" do
      expect(get: "/users/logout").to route_to("users#logout")
    end
  end
end
