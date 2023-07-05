# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    message { 'Sample notification message for test' }
    association :user
  end
end
