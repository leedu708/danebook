FactoryGirl.define do

  factory :comment do

    sequence(:body) { |n| "Foo comment#{n}."}
    author

    trait :on_post do
      association :commentable, :factory => :post
    end

  end

end