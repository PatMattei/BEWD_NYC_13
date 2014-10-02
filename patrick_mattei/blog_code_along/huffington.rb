require_relative "lib/author.rb"
require_relative "lib/post.rb"

puts "Hello, welcome to the Huffington Post."

puts "We need some of your information."

author = Author.new

puts "Please enter your first name"
author.first_name = gets.strip

puts "Please enter your last name"
author.last_name = gets.strip

puts "Please enter your email"
author.email = gets.strip

puts "Thanks, now let's add a blog"

post = Post.new
post.author = author

puts "Please enter the title of your post"
post.title = gets.strip

puts "Please enter the body of your post"
post.body = gets.strip

puts "---------"
puts "Title: #{post.title}"
puts "Author: #{post.author.full_name}, Email: #{post.author.email}"
puts post.body