# Events controller spec

require 'rails_helper'
RSpec.describe 'Events API' do
  let!(:user) { create :user }
  let(:user_id) { user.id }
  let!(:center) { create :center }
  let(:center_id) { center.id }

  describe 'POST api/v1/centers/:id/events' do
    let(:params) {{ event: FactoryBot.attributes_for(:event) }}
    context 'when valid parameters are passed' do
      before do
        post "/api/v1/centers/#{center_id}/events",
             params: params,
             headers: authenticated_headers(user_id)
      end

      it 'should return a 201' do
        expect(response).to have_http_status(201)
      end

      it 'should return an event object' do
        expect(json['data']['event']).to_not be_empty
        expect(json['data']['event']['name']).to match params[:event][:name]
        expect(json['data']['event']['guests']).to match params[:event][:guests].to_i
      end

      it 'should have a center object inside the event object' do
        expect(json['data']['event']['center']).to_not be_empty
        expect(json['data']['event']['center']['name']).to match center.name
        end

      it 'should have a user object inside the event object' do
        expect(json['data']['event']['user']).to_not be_empty
        expect(json['data']['event']['user']['name']).to match user.name
      end
    end

    context 'when posting to an invalid center_id' do
      let(:center_id) { 10000891 }
      before do
        post "/api/v1/centers/#{center_id}/events",
             params: params,
             headers: authenticated_headers(user_id)
      end

      it 'should return a 404' do
        expect(response).to have_http_status(404)
      end
    end
  end
end