admin = User.new(email: "user@test.com", name: "Kurt", password: "111111", password_confirmation: "111111")
if admin.save!
  puts "Create admin #{admin.name}"
end

group = Group.new(title: "Group1", description: "ggg1", user_id: admin.id)
if group.save!
  puts "Create group #{group.title}"
end

post = Post.new(content: "ppp1", group_id: group.id)
if post.save!
  puts "Create post #{post.content}"
end