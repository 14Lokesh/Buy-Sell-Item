# rubocop:disable all
require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:category) { create(:category) }
  let(:user) { create(:user) }

  describe 'positive context' do
    it 'is valid with valid attributes' do
      item = build(:item, category: category, user: user)
      expect(item).to be_valid
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

    it 'accepts valid image content types' do
      valid_image_file = Rack::Test::UploadedFile.new(Rails.root.join('app/assets/images/bed.jpg'), 'image/jpeg')
      item = build(:item, category: category, user: user)
      item.images.attach(valid_image_file)
      expect(item).to be_valid
    end
  end

  describe 'associations' do
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

  describe 'scopes' do
    let!(:user) { create(:user) }
    let!(:approved_item) { create(:item, approved: true) }
    let!(:unapproved_item) { create(:item, approved: false) }
    before do
      create_list(:item, 3, approved: true, user: user)
      create_list(:item, 2, approved: false, user: user)
    end

    describe '.approved_and_not_items_owner' do
      it 'returns approved items not owned by the user' do
        other_user = create(:user)
        other_user_item = create(:item, approved: true, user: other_user)

        expect(Item.approved_and_not_items_owner(user)).to include(other_user_item)
        expect(Item.approved_and_not_items_owner(user)).not_to include(*user.items)
      end
    end

    describe '.approved_by_user' do
      it 'returns approved items owned by the user' do
        approved_items = Item.approved_by_user(user)

        expect(approved_items).to match_array(user.items.where(approved: true))
      end
    end

    describe '.unapproved_by_user' do
      it 'returns unapproved items owned by the user' do
        unapproved_items = Item.unapproved_by_user(user)

        expect(unapproved_items).to match_array(user.items.where(approved: false))
      end
    end

    describe '.approved_items' do
      it 'returns only approved items' do
        expect(Item.approved_items).to include(approved_item)
        expect(Item.approved_items).not_to include(unapproved_item)
      end
    end
  end

  describe '.search_items' do
    let(:query) { 'search query' }
    let(:data) { 'data query' }
    let(:search_definition) { Item.search_items(query, data) }

    context 'when both query and data are present' do
      it 'includes the query_string for title and name' do
        expect(search_definition[:query][:bool][:must]).to include(
          {
            query_string: {
              query: "*#{query}*",
              fields: %i[title name]
            }
          }
        )
      end

      it 'includes the query_string for city and name in filter' do
        expect(search_definition[:query][:bool][:filter]).to include(
          {
            query_string: {
              query: data,
              fields: %i[city name]
            }
          }
        )
      end

      it 'includes the term filter for approved true' do
        expect(search_definition[:query][:bool][:filter]).to include(
          {
            term: {
              approved: true
            }
          }
        )
      end
    end

    context 'when only query is present' do
      let(:data) { nil }

      it 'includes the query_string for title and name' do
        expect(search_definition[:query][:bool][:must]).to include(
          {
            query_string: {
              query: "*#{query}*",
              fields: %i[title name]
            }
          }
        )
      end

      it 'does not include the query_string for city and name in filter' do
        expect(search_definition[:query][:bool][:filter]).not_to include(
          {
            query_string: {
              query: data,
              fields: %i[city name]
            }
          }
        )
      end

      it 'includes the term filter for approved true' do
        expect(search_definition[:query][:bool][:filter]).to include(
          {
            term: {
              approved: true
            }
          }
        )
      end
    end

    context 'when only data is present' do
      let(:query) { nil }

      it 'does not include the query_string for title and name' do
        expect(search_definition[:query][:bool][:must]).not_to include(
          {
            query_string: {
              query: "*#{query}*",
              fields: %i[title name]
            }
          }
        )
      end

      it 'includes the query_string for city and name in filter' do
        expect(search_definition[:query][:bool][:filter]).to include(
          {
            query_string: {
              query: data,
              fields: %i[city name]
            }
          }
        )
      end

      it 'includes the term filter for approved true' do
        expect(search_definition[:query][:bool][:filter]).to include(
          {
            term: {
              approved: true
            }
          }
        )
      end
    end

    context 'when both query and data are empty' do
      let(:query) { nil }
      let(:data) { nil }

      it 'does not include the query_string for title and name' do
        expect(search_definition[:query][:bool][:must]).not_to include(
          {
            query_string: {
              query: "*#{query}*",
              fields: %i[title name]
            }
          }
        )
      end

      it 'does not include the query_string for city and name in filter' do
        expect(search_definition[:query][:bool][:filter]).not_to include(
          {
            query_string: {
              query: data,
              fields: %i[city name]
            }
          }
        )
      end

      it 'includes the term filter for approved true' do
        expect(search_definition[:query][:bool][:filter]).to include(
          {
            term: {
              approved: true
            }
          }
        )
      end
    end
  end
end
