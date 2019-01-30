# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Center, type: :model do
  context 'validate presence of attributes' do
    it { should validate_presence_of(:name)}
    it { should validate_presence_of(:address)}
    it { should validate_presence_of(:capacity)}
    it { should validate_presence_of(:description)}
  end

  context 'validate uniqueness of key' do
    subject { FactoryBot.build :center }
    message = 'has been taken in the location specified'
    it {
      should validate_uniqueness_of(:name)
        .scoped_to(:address).case_insensitive
        .with_message(message)}
  end

  context 'activestorage matcher' do
    it { should have_one(:image_attachment) }
  end
end