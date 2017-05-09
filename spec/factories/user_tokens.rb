FactoryGirl.define do
  factory :user_token do
    user nil
    access_token "MyString"
  end
end
