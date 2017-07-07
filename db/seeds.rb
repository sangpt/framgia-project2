User.create! name: "Example User", email: "example@railstutorial.org",
  password: "12345678", password_confirmation: "12345678", is_admin: "true"

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n + 1}@railstutorial.org"
  password = "password"
  User.create! name: name, email: email, password: password,
    password_confirmation: password
end

users = User.order(:created_at).take 6
20.times do
  title = Faker::Company.name
  content = Faker::Lorem.sentence 5
  users.each{|user| user.posts.create! title: title, content: content}
end

user = users[1]
posts = user.posts.order(created_at: :desc).take 3
10.times do
  content = Faker::Lorem.sentence 5
  posts.each do |post|
    user.comments.create! content: content, post: post
  end
end

posts = Post.all
posts.each do |post|
  user.likes.build(post_id: post.id).save
end
