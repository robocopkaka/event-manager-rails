class Center < ApplicationRecord
  validates_presence_of :name, :description, :address, :capacity
  validates_uniqueness_of :name, scope: :address, case_sensitive: false, message: "has been taken in the location specified"
  has_one_attached :image
end
