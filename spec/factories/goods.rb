FactoryBot.define do
  factory :good do
    association :user
    association :post
  end
end
