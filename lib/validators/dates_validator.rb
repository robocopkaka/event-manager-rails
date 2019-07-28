class DatesValidator < ActiveModel::Validator
  extend DateTimeHelpers
  def validate(record)
    return if record.start_time.nil? || record.end_time.nil?
    start_time = DatesValidator.parse_datetime(record.start_time.to_s, :start_time)
    end_time = DatesValidator.parse_datetime(record.end_time.to_s, :end_time)

    if start_time < DateTime.now
      record.errors[:start_time] << 'Start time is in the past'
    elsif end_time < start_time
      record[:end_time] << 'End time is older than the start time'
    else
      times = Center.find_by(id: record.center_id).all_events.pluck(:start_time, :end_time)
      time_group = { start_time: start_time, end_time: end_time }
      if DatesValidator.time_overlaps?(times, time_group) # uses time_overlaps? method in DateTimeHelpers module
        record.errors[:start_time] << 'Start time or end time overlaps with existing time'
      end
    end
  end
end