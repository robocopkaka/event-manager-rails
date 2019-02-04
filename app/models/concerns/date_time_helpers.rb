module DateTimeHelpers
  def time_overlaps?(times, start_time)
    start_time = parse_datetime(start_time.to_s, :start_time)
    times = times.select do |time|
      # binding.pry
      start_time < time
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

  # Postman requests are failing. Fix tomorrow
  def parse_datetime(datetime, symbol)
    begin
      datetime = DateTime.parse(datetime)
    rescue ArgumentError
      # errors.add(symbol, e.to_s)
    end
    datetime
  end
end