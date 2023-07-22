# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    association :conversation
    association :sender, factory: :user
    association :recipient, factory: :user
    body { 'This is a test message for rspec.' }

    trait :read do
      read { true }
    end

    trait :unread do
      read { false }
    end
  end
end
