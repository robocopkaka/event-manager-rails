class Center < ApplicationRecord
  validates_presence_of :name, :description, :address, :capacity
  validates_uniqueness_of :name
end
