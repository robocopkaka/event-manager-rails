class DatesValidator < ActiveModel::Validator
  include DateTimeHelpers
  def validate(record)
    return if record.start_time.nil? || record.end_time.nil?
    start_time = parse_datetime(record.start_time.to_s, :start_time)
    end_time = parse_datetime(record.end_time.to_s, :end_time)

    if start_time < DateTime.now
      record.errors[:start_time] << 'is in the past'
    elsif end_time < start_time
      record[:end_time] << 'is older than the start time'
    else
      end_times = Center.find_by(id: record.center_id).events.pluck(:end_time)
      if time_overlaps?(end_times, start_time) # uses time_overlaps? method in DateTimeHelpers module
        record.errors[:start_time] << 'overlaps with existing time'
      end
    end
  end
end