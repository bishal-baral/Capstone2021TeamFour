# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Clear the databases before seeding
#TODO Is there some way to disable this on prod?
User.delete_all
Review.delete_all
Friend.delete_all
FriendReview.delete_all

# Make ten users.
10.times do
  u = User.create({
    # Pretend they don't all join at the same time
    join_date: Faker::Time.between({
      from: DateTime.now - 365, 
      to: DateTime.now, 
      format: :default
    }),
    username: Faker::Name.first_name
  })

  # Make a random number of reivews per user
  rand(3..7).times do
    Review.create({
      media: Faker::Movie.title,

      # I felt like chuck norris idk 
      content: Faker::ChuckNorris.fact,
      user_id: u.id, 
      # Randomize the post date.
      post_date: Faker::Time.between({
        from: u.join_date, 
        to: DateTime.now, 
        format: :default
      }), 
      recommended: Faker::Boolean.boolean
    })
  end
end

# Make twenty pairs of friends, and have each friend send the other a review
20.times do
  friend_one = User.all.sample.id
  friend_two = User.all.sample.id
  while friend_one == friend_two do
    friend_two = User.all.sample.id
  end

  # Duplicate the pairs so it's easier to search
  Friend.create({
    user_id: friend_one,
    friend_id: friend_two
  })
  Friend.create({
    user_id: friend_two,
    friend_id: friend_one
  })

  # Send each other a review each
  FriendReview.create({
    user_id: friend_one,
    review_id: Review.where(user_id: friend_two).sample.id
  })
  FriendReview.create({
    user_id: friend_two,
    review_id: Review.where(user_id: friend_one).sample.id
  })

end

