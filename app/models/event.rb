class Event < ApplicationRecord
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
end