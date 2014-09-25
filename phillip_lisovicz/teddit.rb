# Teddit Conditionals

# Let's add a new Teddit feature. Automatic upvotes!
# Complete the application below. 
# Where you see comments (lines that begin with #) replace it with code so that the program works.

def get_input
  gets.strip
end

def calculate_upvotes(story, category)
  # Write code so that:
  upvotes = 1

  if story.include? 'cats'
    upvotes *= 5
  end

  if story.include? 'bacon'
    upvotes *= 8
  end

  if story.include? 'food'
    upvotes *= 6
  end

  upvotes

end

puts "Welcome to Teddit! a text based news aggregator. Get today's news tomorrow!"
puts "Please enter a News story:"
story = get_input
puts "Please give it a category:"
category = get_input
upvotes = calculate_upvotes(story, category)
puts "New story added! #{story}, Category: #{category.capitalize}, Current Upvotes: #{upvotes}"