class EventModel < ActiveRecord::Base
  self.table_name = :events
end

class AddEndTimeToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :end_time, :datetime
    # find nil values after adding end_time column and set values on them
    EventModel.where(end_time: nil).update_all(end_time: DateTime.now + 2.hours)
    # then make the column non-nullable
    change_column_null :events, :end_time, false
  end
end
