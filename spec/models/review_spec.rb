# rubocop:disable all

require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:user) { create(:user) }
  let(:item) { create(:item) }

  describe 'positive context' do
    it 'is valid with valid attributes' do
      review = build(:review, user: user, item: item)
      expect(review).to be_valid
    end

    it 'is valid with minimum rating (1)' do
      review = build(:review, rating: 1, user: user, item: item)
      expect(review).to be_valid
    end

    it 'is valid with maximum rating (5)' do
      review = build(:review, rating: 5, user: user, item: item)
      expect(review).to be_valid
    end
  end

  describe 'negative context' do
    it 'is invalid without content' do
      review = build(:review, content: nil, user: user, item: item)
      expect(review).not_to be_valid
      expect(review.errors[:content]).to include("can't be blank")
    end

    it 'is invalid without a user' do
      review = build(:review, user: nil, item: item)
      expect(review).not_to be_valid
      expect(review.errors[:user]).to include("must exist")
    end

    it 'is invalid without an item' do
      review = build(:review, item: nil, user: user)
      expect(review).not_to be_valid
      expect(review.errors[:item]).to include("must exist")
    end

    it 'is invalid with a rating less than 1' do
      review = build(:review, rating: 0, user: user, item: item)
      expect(review).not_to be_valid
      expect(review.errors[:rating]).to include("must be greater than or equal to 1")
    end

    it 'is invalid with a rating greater than 5' do
      review = build(:review, rating: 6, user: user, item: item)
      expect(review).not_to be_valid
      expect(review.errors[:rating]).to include("must be less than or equal to 5")
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      user = create(:user)
      review = create(:review, user: user)
      expect(review.user).to eq(user)
    end

    it 'belongs to an item' do
      item = create(:item)
      review = create(:review, item: item)
      expect(review.item).to eq(item)
    end
  end
end
