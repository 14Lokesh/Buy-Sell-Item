# rubocop:disable all
require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'positive context' do
    let(:category) { create(:category) }
    let(:user) { create(:user) }

    it 'is valid with valid attributes' do
      item = build(:item, category: category, user: user)
      expect(item).to be_valid
    end

    it 'has an associated category' do
      item = create(:item, category: category, user: user)
      expect(item.category).to eq(category)
    end

    it 'has an associated user' do
      item = create(:item, category: category, user: user)
      expect(item.user).to eq(user)
    end

    it 'destroys associated reviews when item is destroyed' do
      item = create(:item, category: category, user: user)
      create_list(:review, 3, item: item)

      expect { item.destroy }.to change(Review, :count).by(-3)
    end
  end

  describe 'negative context' do
    let(:category) { create(:category) }
    let(:user) { create(:user) }

    it 'is invalid without a title' do
      item = build(:item, title: nil, category: category, user: user)
      item.valid?

      expect(item.errors[:title]).to include("can't be blank")
    end

    it 'is invalid without a description' do
      item = build(:item, description: nil, category: category, user: user)
      item.valid?

      expect(item.errors[:description]).to include("can't be blank")
    end

    it 'is invalid without a phone number' do
      item = build(:item, phone: nil, category: category, user: user)
      item.valid?

      expect(item.errors[:phone]).to include("can't be blank")
    end

    it 'is invalid with an invalid phone number format' do
      item = build(:item, phone: '12345', category: category, user: user)
      item.valid?
      expect(item.errors[:phone]).to include('must be a valid phone number')
    end

    it 'is invalid without a username' do
      item = build(:item, username: nil, category: category, user: user)
      item.valid?

      expect(item.errors[:username]).to include("can't be blank")
    end

    it 'is invalid without a city' do
      item = build(:item, city: nil, category: category, user: user)
      item.valid?

      expect(item.errors[:city]).to include("can't be blank")
    end

  end
end
