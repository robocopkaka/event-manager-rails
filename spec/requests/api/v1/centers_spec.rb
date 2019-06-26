# Centers requests spec
require 'rails_helper'

RSpec.describe 'Centers API', type: :request do
  let!(:user) { create :user, admin: true }
  let!(:centers) { create_list :center, 10, user: user }
  let(:center_id) { centers.first.id }

  context 'GET /api/v1/centers' do
    before { get api_v1_centers_path }

    it 'returns the centers in the database' do
      expect(json).to_not be_empty
      expect(json["data"]["centers"].count).to eq 10
    end

    it 'returns 200 as it\'s status code' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/v1/centers/:id' do
    context 'when the record exists' do
      before { get "/api/v1/centers/#{center_id}" }

      it 'should return the specified center' do
        expect(json).to_not be_empty
        expect(json["data"]["center"]["id"]).to eq center_id
      end

      it 'should return 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record is does not exist' do
      let(:center_id) { 1000 }
      before { get "/api/v1/centers/#{center_id}" }

      it 'should return a 404' do
        expect(response).to have_http_status(404)
      end

      it 'should return an error message' do
        expect(json["message"]).to eq "Resource was not found"
      end
    end
  end

  describe 'post /api/v1/users/:user_id/centers' do
    let(:params) {{ center: attributes_for(:center)}}


    context 'when it receives valid input' do
      let!(:user) { create :user, admin: true}
      before { post api_v1_centers_path, params: params, headers: authenticated_headers(user.id) }

      it 'should return an object containing the newly created center' do
        expect(json).to_not be_empty
        expect(json["data"]["center"]["name"]).to match params[:center][:name]
        expect(json["data"]["center"]["address"]).to match params[:center][:address]
      end

      it 'should respond with a 201 status code' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when it receives invalid parameters' do
      let!(:user) { create :user, admin: true}

      before do
        invalid_params = { center: FactoryBot.attributes_for(:center) }
        invalid_params[:center].delete(:name)
        post api_v1_centers_path, params: invalid_params, headers: authenticated_headers(user.id)
      end

      it 'should return a 422' do
        expect(response).to have_http_status(422)
      end

      it 'should have an error message' do
        expect(json["error"]).to match 'unprocessable_entity'
      end
    end
  end

  describe 'PUT /api/v1/centers/:id' do
    let!(:user) { create :user, admin: true }
    let(:params) {{ center: attributes_for(:center)}}

    context 'when it receives valid parameters' do
      before do
        headers = authenticated_headers(user.id)
        put "/api/v1/centers/#{center_id}", params: params, headers: headers
      end

      it 'should  return a 200' do
        expect(response).to have_http_status(200)
      end

      it 'should have the attributes in the center match the parameters that were passed in' do
        expect(json["data"]["center"]["address"]).to eq params[:center][:address]
        expect(json["data"]["center"]["capacity"]).to eq params[:center][:capacity].to_i
      end
    end

    context 'when it receives an invalid id' do
      let(:center_id) { 40009 }
      before do
        headers = authenticated_headers(user.id)
        put "/api/v1/centers/#{center_id}", params: params, headers: headers
      end

      it 'should return a 404 status code' do
        expect(response).to have_http_status(404)
      end
    end
  end
end