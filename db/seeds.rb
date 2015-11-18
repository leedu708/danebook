User.delete_all
Profile.delete_all
Post.delete_all
Comment.delete_all
Like.delete_all

puts "Old records destroyed."

# Create 50 Users with Profiles
50.times do
  u = User.new
  u.password = 'password'
  p = u.build_profile
  p.first_name = Faker::Name.first_name
  p.last_name = Faker::Name.last_name
  u.email = Faker::Internet.email("#{p.first_name}.#{p.last_name}")
  p.gender = ['Male', 'Female'].sample
  p.birthdate = Faker::Date.between(90.years.ago, 12.years.ago)
  p.college = Faker::Lorem.word.titleize
  p.hometown = Faker::Address.city
  p.currently_lives = Faker::Address.city
  p.telephone = Faker::PhoneNumber.phone_number
  p.words_to_live_by = Faker::Lorem.sentence
  p.description = Faker::Lorem.paragraph(1,true,3)
  u.save!
end

puts "Users and profiles created."

User.all.each do |u|
  # Create 2-6 Posts for each User
  rand(2..6).times do
    p = u.posts.build
    p.body = Faker::Lorem.paragraph(1,true,3)
    p.save!
  end

  # Create 3-10 Comments for each User on random other user posts
  rand(3..10).times do
    p = Post.all.sample
    c = p.comments.build
    c.author_id = u.id
    c.body = Faker::Lorem.paragraph(1,true,1)
    p.save!
  end

  # Create friends for users
  rand(5..25).times do
    add_friend = User.all.sample
    u.friended_users << add_friend unless u.friended_users.include?(add_friend)
  end

end

puts "User posts, comments, and friends created."

# For each Post & each Comment, pick 0-7 random Users to Like it
def assign_likes(object)
  rand(0..7).times do
    random_user = User.all.sample
    object.likers << random_user unless object.liker_ids.include?(random_user.id)
  end
end

Post.all.each do |p|
  assign_likes(p)
end

Comment.all.each do |c|
  assign_likes(c)
end

puts "User likes added."

puts "COMPLETE!"