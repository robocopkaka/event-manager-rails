class Event < ApplicationRecord
  include ActiveModel::Validations
  include Concerns::Docs::Event
  belongs_to :center
  belongs_to :user

  validates_presence_of :name, :description, :guests
  validates_uniqueness_of :name, case_sensitive: false, scope: :center_id, message: "Name has already been taken in center"
  validates :start_time, timeliness: { type: :datetime }
  validates :end_time, timeliness: { type: :datetime }
  validates_with DatesValidator
end