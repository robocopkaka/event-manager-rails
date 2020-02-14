desc "Send out emails for upcoming events"
task :upcoming_events => :environemnt do
  UpcomingEventsWorker.perform_async
end