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

  end
end