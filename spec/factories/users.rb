FactoryGirl.define do
  sequence(:email) { |n| Faker::Internet.safe_email 'User %d' % n }
  sequence(:name) { |n| 'Test User %d' % n }
end

FactoryGirl.define do
  
  factory :user do
    email
    name
    password '12345678'
    password_confirmation '12345678'

    trait :regular do
      role 'regular'
    end

    trait :manager do
      role 'manager'
    end

    trait :admin do
      role 'admin'
    end

  end # of factory :user

  factory :user_with_token, parent: :user do
    after :build do |user, evaluator|
      user.user_tokens.build
    end
  end # of factory :user_with_token

end