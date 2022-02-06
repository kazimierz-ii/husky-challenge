require "rails_helper"

RSpec.describe TokensController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/tokens").to route_to("tokens#index")
    end

    it "routes to #new" do
      expect(get: "/tokens/new").to_not be_routable
    end

    it "routes to #show" do
      expect(get: "/tokens/1").to_not be_routable
    end

    it "routes to #edit" do
      expect(get: "/tokens/1/edit").to_not be_routable
    end

    it "routes to #create" do
      expect(post: "/tokens").to route_to("tokens#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/tokens/1").to_not be_routable
    end

    it "routes to #update via PATCH" do
      expect(patch: "/tokens/1").to_not be_routable
    end

    it "routes to #destroy" do
      expect(delete: "/tokens/1").to_not be_routable
    end

    it "routes to #activate" do
      expect(get: "/tokens/token-from-email/activate").to route_to("tokens#activate", id: "token-from-email")
    end
  end
end
