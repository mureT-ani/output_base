FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.name }
    email                 { Faker::Internet.free_email }
    password              { 'test1234TEST' }
    password_confirmation { password }
    job_id                { Faker::Number.between(from: 2, to: 4) }
    birthday              { Faker::Date.between(from: '1930-01-01', to: 5.year.ago) }
  end
end
