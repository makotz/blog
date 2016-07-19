# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# 15.times do
#   Post.create title: Faker::Book.title,
#               body: Faker::Lorem.paragraph,
#               user_id: rand(1..4)
# end

# ["Sports","Arts","Awesome","Technology","News"].each do |cat|
#   Category.create name: cat
# end


# Comment.all.each do |x|
#   x.user_id = rand(1..4)
#   x.save
# end

Post.all.each do |x|
  x.user_id = rand(1..4)
  x.save
end
