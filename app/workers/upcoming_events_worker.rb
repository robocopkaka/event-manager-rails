# frozen_string_literal: true

# Worker for sending emails for upcoming events
class UpcomingEventsWorker
  include Sidekiq::Worker

  def perform
    users = User.all

    users.each do |user|
      events = find_events(user)
      unless events.empty?
        UserMailer.with(user: user, events: events).upcoming_events.deliver_now
      end
    end
  end

  private

  def find_events(user)
    user.reservations.select do |event|
      interval = ((event.start_time - Time.now) / 24.hours.to_i).ceil
      interval.in?(1..8)
    end
  end
end
