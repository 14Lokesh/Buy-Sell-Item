FactoryBot.define do
  factory :review do
    content { 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.' }
    rating { 4 }
    association :user
    association :item
  end
end
