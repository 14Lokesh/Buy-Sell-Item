FactoryBot.define do
  factory :notification do
    message { 'Sample notification message' }
    association :user
    
  end
end
