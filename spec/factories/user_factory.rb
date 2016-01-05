FactoryGirl.define do

  factory :user, aliases: [:poster, :liker, :friend_initiator, :friend_recipient] do

    sequence(:email) { |n| "foo#{n}@test.com" }
    password "password"
    association :profile, factory: :full_profile

  end

end