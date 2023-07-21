# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validations' do
    it 'validates presence of category' do
      category = build(:category, name: nil)
      expect(category).not_to be_valid
    end

    it 'validates length of category' do
      category = build(:category, name: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
      expect(category).not_to be_valid
    end

    it 'validates uniqueness of category' do
      existing_category = create(:category, name: 'Existing category')
      category = build(:category, name: existing_category.name)
      expect(category).not_to be_valid
    end
  end
end
