# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  let(:user) { create :user }
  let(:events) { create_list :event, 2 }

  describe "#upcoming_events" do
    context "when this mailer method is called" do
      it "delivers the email" do
        expect do
          UserMailer
            .with(user: user, events: events)
            .upcoming_events
            .deliver_now
        end.to change(ActionMailer::Base.deliveries, :size).by 1
      end

      it "sends out a mail containing events to a user" do
        email = UserMailer
                  .with(user: user, events: events)
                  .upcoming_events
        expect(email.from).to include "manager@kachi_events.com"
        expect(email.to).to include user.email
        expect(email.subject).to eq "Your events this week"
        expect(email.body.to_s).to include events.first.name
        expect(email.body.to_s)
          .to include events.second.start_time.strftime("%B %d, %Y")
      end
    end
  end
end
