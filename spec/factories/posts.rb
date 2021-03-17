FactoryBot.define do
  factory :post do
    title     { Faker::Lorem.sentence }
    post_text { Faker::Lorem.sentence }
    association :user
  end
end
