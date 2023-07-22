# rubocop:disable all


require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'positive scenarios' do
    context 'when the category name is valid' do
      it 'is valid with a unique name and maximum length of 20' do
        category = build(:category, name: 'Valid Category Name')

        expect(category).to be_valid
      end
    end
  end

  describe 'negative scenarios' do
    context 'when the category name is missing' do
      it 'is invalid without a name' do
        category = build(:category, name: nil)

        expect(category).not_to be_valid
        expect(category.errors[:name]).to include("can't be blank")
      end
    end

    context 'when the category name is longer than 20 characters' do
      it 'is invalid with a name longer than 20 characters' do
        category = build(:category, name: 'This category name is longer than twenty characters.')

        expect(category).not_to be_valid
        expect(category.errors[:name]).to include('is too long (maximum is 20 characters)')
      end
    end

    context 'when the category name is not unique' do
      it 'is invalid with a non-unique name' do
        create(:category, name: 'Existing Category')
        category = build(:category, name: 'Existing Category')

        expect(category).not_to be_valid
        expect(category.errors[:name]).to include('has already been taken')
      end
    end
  end
  describe 'associations' do
    it 'has many items' do
      categories = create(:category)
      item1 = create(:item, category: categories)
      item2 = create(:item, category: categories)

      expect(categories.items).to include(item1, item2)
    end

    it 'destroys associated items when category is destroyed' do
      categories = create(:category)
      create_list(:item, 3, category: categories)

      expect { categories.destroy }.to change(Item, :count).by(-3)
    end
  end
end
