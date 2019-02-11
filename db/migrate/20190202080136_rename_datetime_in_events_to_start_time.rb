class RenameDatetimeInEventsToStartTime < ActiveRecord::Migration[5.2]
  def change
    rename_column :events, :datetime, :start_time
  end
end
