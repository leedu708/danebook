FactoryGirl.define do

  factory :user, aliases: [:author, :liker, :friend_initiator, :friend_recipient, :owner] do

    sequence(:email) { |n| "foo#{n}@test.com" }
    password "password"
    association :profile, factory: :full_profile

  end

end