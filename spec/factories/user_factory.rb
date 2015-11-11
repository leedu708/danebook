FactoryGirl.define do

  factory :user, aliases: [:author, :liker] do

    sequence(:email) { |n| "foo#{n}@test.com" }
    password "password"

  end

end