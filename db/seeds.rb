usernames = ["alice", "bob", "carol", "dave", "ellen"]

usernames.each do |username|
  user = User.new
  user.username = username
  user.email = "#{username}@example.com"
  user.password = "12341234"
  user.save
end

puts "There are now #{User.count} users in the database."

photo_info = [
  {
    :image => "http://upload.wikimedia.org/wikipedia/commons/thumb/e/e9/Lake_Bondhus_Norway_2862.jpg/1280px-Lake_Bondhus_Norway_2862.jpg",
    :caption => "Lake Bondhus"
  },
  {
    :image => "http://upload.wikimedia.org/wikipedia/commons/thumb/1/10/Lanzarote_5_Luc_Viatour.jpg/1280px-Lanzarote_5_Luc_Viatour.jpg",
    :caption => "Cueva de los Verdes"
  },
  {
    :image => "http://upload.wikimedia.org/wikipedia/commons/thumb/0/02/Fire_breathing_2_Luc_Viatour.jpg/1280px-Fire_breathing_2_Luc_Viatour.jpg",
    :caption => "Jaipur"
  },
  {
    :image => "http://upload.wikimedia.org/wikipedia/commons/thumb/2/2d/Ніжний_ранковий_світло.jpg/1280px-Ніжний_ранковий_світло.jpg",
    :caption => "Sviati Hory"
  },
  {
    :image => "http://upload.wikimedia.org/wikipedia/commons/thumb/d/d7/Mostar_Old_Town_Panorama_2007.jpg/1280px-Mostar_Old_Town_Panorama_2007.jpg",
    :caption => "Mostar"
  },
  {
    :image => "http://upload.wikimedia.org/wikipedia/commons/thumb/b/b3/Elakala_Waterfalls_Swirling_Pool_Mossy_Rocks.jpg/1280px-Elakala_Waterfalls_Swirling_Pool_Mossy_Rocks.jpg",
    :caption => "Elakala"
  },
  {
    :image => "http://upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Biandintz_eta_zaldiak_-_modified2.jpg/1280px-Biandintz_eta_zaldiak_-_modified2.jpg",
    :caption => "Biandintz"
  }
]

users = User.all

User.all.each do |user|
  photo_info.each do |photo_hash|
    filename = photo_hash[:image].split('/').last

    photo = Photo.new
    photo.image = File.open(Rails.root.join('lib', 'assets', filename).to_s)
    photo.caption = photo_hash[:caption]
    photo.user_id = user.id
    photo.save

    puts photo.errors.full_messages
  end
end

puts "There are now #{Photo.count} photos in the database."

photos = Photo.all

photos.each do |photo|
  rand(6).times do
    comment = photo.comments.build
    comment.user = users.sample
    comment.body = Faker::Hacker.say_something_smart
    comment.save
  end
end

puts "There are now #{Comment.count} comments in the database."

photos.each do |photo|
  users.sample(rand(users.count)).each do |user|
    like = photo.likes.build
    like.user = user
    like.save
  end
end

puts "There are now #{Like.count} likes in the database."

User.all.each do |receiver|
  users.sample(rand(users.count)).each do |sender|
    FriendRequest.create sender: sender, receiver: receiver
  end
end

puts "There are now #{FriendRequest.count} friend requests in the database."
