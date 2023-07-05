# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    body { 'Sample message body for test' }
    association :conversation
    association :sender, factory: :user
    association :recipient, factory: :user
  end
end
