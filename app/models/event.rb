class Event < ApplicationRecord
  belongs_to :center
  belongs_to :user
  before_validation :assign_user

  validates_presence_of :name, :description, :guests, :datetime
  validates_uniqueness_of :name, case_sensitive: false
  # validate :valid_date, on: %i[create update]

  def assign_user
    self.user_id = CurrentUser.user.id
  end

  def valid_date
    #https://stackoverflow.com/questions/8607266/validating-datetime-format-in-model
    if (DateTime.parse(self.datetime.to_s) rescue ArgumentError) == ArgumentError
      errors.add('invalid date')
    end
  end
end
