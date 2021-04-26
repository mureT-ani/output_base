FactoryBot.define do
  factory :tag do
    name      {Faker::Lorem.sentence}
    
    after(:create) do |tag|
      create(:post_tag, tag: tag, post: create(:post))
    end
  end
end