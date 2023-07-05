FactoryBot.define do
  factory :item do
    title { 'Sample Item Title' }
    description { 'Sample item description' }
    phone { '1234567890' }
    username { 'sample_username' }
    city { 'Sample City' }
    association :category
    association :user
  end
end
