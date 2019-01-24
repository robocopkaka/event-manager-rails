module NullAttributesRemover
  # *args can be replaced with adapter_options = nil, options = {}, adapter_instance = self.class.serialization_adapter_instance
  def serializable_hash(*args)
    super.compact
  end
end