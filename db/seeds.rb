# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Clear the databases before seeding
#TODO Is there some way to disable this on prod?
User.destroy_all
Review.delete_all
Friendship.destroy_all
Tag.destroy_all
ReviewTag.destroy_all
# FriendReview.delete_all

# Create plaintext for local passwords
pw_store = File.open("passwords.txt", "w")


Tag.create(category: "Medium", name: "TV show")
Tag.create(category: "Medium", name: "Youtube")
Tag.create(category: "Medium", name: "Anime")
Tag.create(category: "Medium", name: "Video game")
movie = Tag.create(category: "Medium", name: "Movie")

# Make ten users.
10.times do
  name = Faker::Name.first_name
  pw = Faker::Internet.password(min_length: 10, max_length: 20)
  user_email = Faker::Internet.email
  code = rand(1000...9999)
  pw_store.puts "#{name}: #{user_email}, #{pw}, #{code}"

  u = User.create({
    # Pretend they don't all join at the same time
    join_date: Faker::Time.between({
      from: DateTime.now - 365, 
      to: DateTime.now, 
      format: :default
    }),
    username: name,
    code: code,
    email: user_email,
    password: pw
  })

  # Make a random number of reivews per user
  rand(3..7).times do
    r = Review.create({
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
    
    # Add them to the movie tag
    ReviewTag.create({
      review_id: r.id,
      tag_id: movie.id
    })
  end
end
pw_store.close

# Make twenty pairs of friends, and have each friend send the other a review
20.times do
  begin
    friend_one = User.all.sample.id
    friend_two = User.all.sample.id
    Friendship.create({
      sent_by_id: friend_one,
      sent_to_id: friend_two,
      status: true
    })

  rescue
    retry
  end
end

