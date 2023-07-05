# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it 'validates presence of title' do
      item = build(:item, title: nil)
      expect(item).not_to be_valid
    end

    it 'validates length of title' do
      item = build(:item, title: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
      expect(item).not_to be_valid
    end

    it 'validates presence of description' do
      item = build(:item, description: nil)
      expect(item).not_to be_valid
    end

    it 'validates length of description' do
      item = build(:item, description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce hendrerit.')
      expect(item).to be_valid
    end

    it 'validates presence and format of phone' do
      item = build(:item, phone: nil)
      expect(item).not_to be_valid

      item = build(:item, phone: '1234567890')
      expect(item).to be_valid

      item = build(:item, phone: '123')
      expect(item).not_to be_valid

      item = build(:item, phone: 'abcdefghij')
      expect(item).not_to be_valid
    end

    it 'validates presence of username' do
      item = build(:item, username: nil)
      expect(item).not_to be_valid
    end

    it 'validates presence of city' do
      item = build(:item, city: nil)
      expect(item).not_to be_valid
    end
  end
end
