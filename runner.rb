require './lib/museum'
require './lib/patron'



def print_instructions
  puts "Press 'e' to add an exhibit to the museum"
  puts "Press 'a' to admit a new patron to the museum"
  puts "Press 'r' to see the total revenue generated"
  puts "Press 't' to see the top exhibits"
  puts "Press 'u' to remove unpopular exhibits"
  puts "Press 'q' to exit"
end

def add_exhibit(museum)
  puts "What is the name of the exhibit?"
  name = gets.chomp
  puts "How much does the exhibit cost?"
  cost = gets.chomp.to_i
  museum.add_exhibit(name, cost)
end

def admit(museum)
  puts "What is the name of the Patron?"
  name = gets.chomp
  patron = Patron.new(name)
  puts "What exhibits are they interested in? (Enter x to stop)"
  interest = gets.chomp
  while interest != 'x'
    patron.add_interest(interest)
    interest = gets.chomp
  end
  museum.admit(patron)
end

def revenue(museum)
  puts "Museum revenue is #{museum.revenue}."
end

def top_exhibits(museum)
  puts "Top exhibits are #{museum.exhibits_by_attendees.to_s}."
end

def remove_unpopular_exhibits(museum)
  puts "What is the threshold?"
  threshold = gets.chomp.to_i
  museum.remove_unpopular_exhibits(threshold)
end

puts "What is the name of the museum?"
name = gets.chomp
museum = Museum.new(name)

loop do
  print_instructions
  input = gets.chomp
  if input == 'e'
    add_exhibit(museum)
  elsif input == 'a'
    admit(museum)
  elsif input == 'r'
    revenue(museum)
  elsif input == 't'
    top_exhibits(museum)
  elsif input == 'u'
    remove_unpopular_exhibits(museum)
  elsif input == 'q'
    break
  else
    puts "Invalid Input"
  end
end
