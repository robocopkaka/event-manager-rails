# frozen_string_literal: true

require "rails_helper"
require "sidekiq/testing"
require "sidekiq/extensions/action_mailer"
RSpec.describe UpcomingEventsWorker do
  let(:user) { create :user }
  let(:event) { create :event, user: user, start_time: Time.now + 5.days }
  before { ActionMailer::Base.deliveries.clear }

  context "when the worker is called" do
    it "should push a job onto the queue" do
      Sidekiq::Testing.fake!
      expect do
        UpcomingEventsWorker.perform_async
      end.to change(UpcomingEventsWorker.jobs, :size).by 1
    end
  end

  context "when user has upcoming events" do
    before do
      FactoryBot.create(:booking, event: event, user: user)
    end
    it "should send out mails to the user" do
      Sidekiq::Testing.inline! do
        3.times { UpcomingEventsWorker.perform_async }
        expect(ActionMailer::Base.deliveries.size).to eq 3
      end
    end
  end

  context "when user has no upcoming event" do
    it "shouldn't send out any mail to the user" do
      Sidekiq::Testing.inline! do
        3.times { UpcomingEventsWorker.perform_async }
        expect(ActionMailer::Base.deliveries.size).to eq 0
      end
    end
  end
end
