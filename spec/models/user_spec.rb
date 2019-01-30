# User model spec
require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validate presence of keys' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
  end

  context 'validate uniqueness' do
    it { should validate_uniqueness_of(:email).case_insensitive }
  end
end