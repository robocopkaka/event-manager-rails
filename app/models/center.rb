class Center < ApplicationRecord
  validates_presence_of :name, :description, :address, :capacity
end
