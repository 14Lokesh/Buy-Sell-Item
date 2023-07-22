# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    association :category
    association :user
    title { 'Sample Item Title' }
    description { 'Sample item description' }
    phone { '8292066408' }
    username { 'sample_username' }
    city { 'Sample City' }
  end
end
