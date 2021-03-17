FactoryBot.define do
  factory :post do
    post_text { Faker::Lorem.sentence }
    association :user
  end
end
