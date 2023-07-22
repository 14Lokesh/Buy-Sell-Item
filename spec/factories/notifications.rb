# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    association :user
    message { 'Sample notification message for test' }
  end
end
