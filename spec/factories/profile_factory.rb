FactoryGirl.define do

  factory :profile do

    first_name "Foo"
    sequence(:last_name) { |n| "Test#{n}" }
    gender "Male"
    birthdate 20.years.ago
    college "Test University"
    hometown "Fooville"
    currently_lives "Testing City"
    telephone "456-654-4565"
    words_to_live_by "Cool quote."
    description "Cool sentences."
    user

  end

end