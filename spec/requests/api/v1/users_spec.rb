# Users' controller spec for API::V1
require 'rails_helper'

RSpec.describe 'Users API' do
  let(:params) {{ user: attributes_for(:user) }}

  describe 'POST /api/v1/users' do
    context 'when it receives valid parameters' do
      before { post '/api/v1/users', params: params }

      it 'should return a 201 status code' do
        expect(response).to have_http_status(201)
      end

      it 'should have the attributes of the created user match the attributes in the object sent in' do
        expect(json["data"]["user"]["name"]).to eq params[:user][:name]
        expect(json["data"]["user"]["email"]).to eq params[:user][:email]
      end
    end

    context 'when it receives invalid parameters' do
      before do
        invalid_params = { user: FactoryBot.attributes_for(:user) }
        invalid_params[:user].delete(:name)
        post '/api/v1/users', params: invalid_params
      end

      it 'should return a 422 status code' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'GET /api/v1/users/:id' do
    let!(:users) { create_list :user, 10 }
    let(:user_id) { users.first.id }

    context 'when a valid id is passed' do
      before do
        get "/api/v1/users/#{user_id}", headers: authenticated_headers(user_id)
      end

      it 'should return a 200 status code' do
        expect(response).to have_http_status(200)
      end

      it 'returns the actual user object' do
        expect(json["data"]["user"]).to_not be_empty
        expect(json["data"]["user"]["id"]).to eq users.first["id"]
        expect(json["data"]["user"]["name"]).to eq users.first["name"]
        expect(json["data"]["user"]).to_not have_key :password
      end
    end
  end
end
