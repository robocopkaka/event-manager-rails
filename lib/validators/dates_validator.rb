# frozen_string_literal: true

# class used to help validate dates
class DatesValidator < ActiveModel::Validator
  extend DateTimeHelpers
  def validate(record)
    return if record.start_time.nil? || record.end_time.nil?

    @start_time = DatesValidator.parse_datetime(record.start_time.to_s)
    @end_time = DatesValidator.parse_datetime(record.end_time.to_s)

    record.center.nil? ? with_event(record) : with_center(record)
  end

  private

  def with_center(record)
    check_time(record)

    times = Center
            .find_by(id: record.center_id)
            .all_events.pluck(:start_time, :end_time)
    time_group = { start_time: @start_time, end_time: @end_time }

    # uses time_overlaps? method in DateTimeHelpers module
    return unless DatesValidator.time_overlaps?(times, time_group)

    message = 'Start time or end time overlaps with existing time'
    record.errors[:start_time] << message
  end

  def with_event(record)
    check_time(record)
    times = User
            .find_by(id: record.user_id)
            .all_events.pluck(:start_time, :end_time)
    time_group = { start_time: @start_time, end_time: @end_time }

    return unless DatesValidator.time_overlaps?(times, time_group)

    message = 'You have an overlapping event at this time'
    record.errors[:start_time] << message
  end

  def check_time(record)
    if @start_time < DateTime.now
      record.errors[:start_time] << 'Start time is in the past'
    elsif @end_time < @start_time
      record.errors[:end_time] << 'End time is older than the start time'
    end
  end
end
