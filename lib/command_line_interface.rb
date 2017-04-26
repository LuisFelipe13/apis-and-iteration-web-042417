def welcome
  # puts out a welcome message here!
  puts "Hello, and may the force with be with you."
end

def get_character_from_user
  puts "please enter a character"
  character = gets.chomp
  character
  # use gets to capture the user's input. This method should return that input, downcased.
end
