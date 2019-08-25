class CenterSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  include NullAttributesRemover
  attributes :id, :name, :address, :capacity, :description, :image
  has_one :address

  def image
    rails_blob_path(object.image, only_path: true) if object.image.attached?
  end
end
