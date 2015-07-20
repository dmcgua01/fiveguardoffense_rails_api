#TODO: remove these factories because they don't work well with mongoid
FactoryGirl.define do

  factory :user do
    first_name "Joe"
    last_name "Shmoe"
    sequence(:email) { |n| "user#{n}@gmail.com" }
    sequence(:password) { |n| "password#{n}" }
    sequence(:api_key) { |n| "api_key#{n}" }
    is_admin false
  end

end
