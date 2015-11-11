FactoryGirl.define do

  factory :user, aliases: [:author, :liker] do

    sequence(:email) { |n| "foo#{n}@test.com" }
    password "password"
    association :profile, factory: :full_profile

  end

end