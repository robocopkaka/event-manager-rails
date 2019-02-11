module DateTimeHelpers
  def time_overlaps?(existing_times, new_time)
    start_time = parse_datetime(new_time[:start_time].to_s, :start_time)
    end_time = parse_datetime(new_time[:end_time].to_s, :end_time)
    times = existing_times.select do |time_group|
      # time_group[0] -> start times | time_group[1] -> end times
      start_time < time_group[1] && end_time > time_group[0]
      # how condition works -> check if incoming start time is less than an existing
      # end time for that center and then checks if the incoming end time if greater
      # than an existing start time. If condition is true, the time_group is tracked by
      # the select block
    end
    if times.count > 0
      true
    end
  end

  def dates_in_past?(record)
    start_time = parse_datetime(record.start_time.to_s, :start_time)
    end_time = parse_datetime(record.end_time.to_s, :end_time)
    if start_time < DateTime.now
      errors.add(:start_time, 'is in the past')
    end

    if end_time < start_time
      errors.add(:end_time, 'is older than the start time')
    end
  end

  def parse_datetime(datetime, symbol)
    begin
      datetime = DateTime.parse(datetime)
    rescue ArgumentError => e
      errors.add(symbol, e.to_s)
    end
    datetime
  end
end