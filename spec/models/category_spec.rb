# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validations' do
    it 'validates presence of category' do
      category = build(:category, category: nil)
      expect(category).not_to be_valid
    end

    it 'validates length of category' do
      category = build(:category, category: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
      expect(category).not_to be_valid
    end

    it 'validates uniqueness of category' do
      existing_category = create(:category, category: 'Existing category')
      category = build(:category, category: existing_category.category)
      expect(category).not_to be_valid
    end
  end
end
