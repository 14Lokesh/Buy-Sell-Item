# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    content { 'just checking the content file' }
    rating { 4 }
    association :user
    association :item
  end
end
