class Event < ApplicationRecord
  require_relative 'validators/dates_validator'
  include DateTimeHelpers
  include ActiveModel::Validations
  belongs_to :center
  belongs_to :user
  before_validation :assign_user

  validates_presence_of :name, :description, :guests
  validates_uniqueness_of :name, case_sensitive: false
  validates :start_time, timeliness: { type: :datetime }
  validates :end_time, timeliness: { type: :datetime }
  # validate :time_overlaps, :dates_in_past, on: %i[create update]
  validates_with DatesValidator


  def assign_user
    self.user_id = CurrentUser.user.id # uses CurrentUser module in the concerns folder
  end

  # def time_overlaps
  #   return if self.start_time.nil?
  #   end_times = Center.find_by(id: self.center_id).events.pluck(:end_time)
  #   if time_overlaps?(end_times, self.start_time) # uses time_overlaps? method in DateTimeHelpers module
  #     errors.add(:start_time, 'overlaps with existing time')
  #   end
  # end
  #
  # def dates_in_past
  #   return if self.start_time.nil? || self.end_time.nil?
  #   dates_in_past?(self) # uses dates_in_past? method in DateTimeHelpers module
  # end
end
