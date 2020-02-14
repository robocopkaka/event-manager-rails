require "rails_helper"
require "rake"

describe "upcoming events" do
  before do
    Rake.application.rake_require "tasks/upcoming_events"
    Rake::Task.define_task(:environment)
  end

  let(:run_rake_task) do
    Rake::Task["upcoming_events"].reenable
    Rake.application.invoke_task "upcoming_events"
  end

  it "should invoke the task" do
    expect(Rake::Task["upcoming_events"]).to receive(:invoke)
    run_rake_task
  end
end