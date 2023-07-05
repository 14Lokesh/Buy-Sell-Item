require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      review = build(:review)
      expect(review).to be_valid
    end

    it 'is not valid without content' do
      review = build(:review, content: nil)
      expect(review).not_to be_valid
    end

    it 'is not valid without a rating' do
      review = build(:review, rating: nil)
      expect(review).not_to be_valid
    end

    it 'is not valid with a non-integer rating' do
      review = build(:review, rating: 4.5)
      expect(review).not_to be_valid
    end

    it 'is not valid with a rating less than 1' do
      review = build(:review, rating: 0)
      expect(review).not_to be_valid
    end

    it 'is not valid with a rating greater than 5' do
      review = build(:review, rating: 6)
      expect(review).not_to be_valid
    end
  end
end
