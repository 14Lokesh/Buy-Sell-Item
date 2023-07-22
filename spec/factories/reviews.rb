# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    association :user
    association :item
    content { 'just checking the content file' }
    rating { 4 }
  end
end
