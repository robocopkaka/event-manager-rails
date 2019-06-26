require "rails_helper"

RSpec.describe CenterService do
  let!(:user) { create :user }
  let!(:unattached_centers) { create_list :center, 5 }
  let(:user_params) { { user_id: user.id } }

  context "when user_id is in params" do
    let!(:centers) { create_list :center, 10, user: user }
    it "returns centers created by the user" do
      centers = CenterService.fetch_centers(user_params)
      user_ids = centers.pluck(:user_id).uniq

      expect(user_ids.count).to eq 1
      expect(user_ids.first).to eq user.id
      expect(centers).to eq centers
    end
  end

  context "when no user id is passed" do
    let!(:more_centers) { create_list :center, 10 }

    it "returns all the centers" do
      centers = CenterService.fetch_centers

      expect(centers.count).to eq 15
      expect(centers).to eq unattached_centers + more_centers
    end
  end

  context "when invalid params are passed" do
    let(:params) { { fish: "fs" } }

    it "returns all the centers" do
      centers = CenterService.fetch_centers(params)
      expect(centers.count).to eq 5
      expect(centers).to eq centers
    end
  end
end