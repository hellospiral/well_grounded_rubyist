# 6.1.2 Assignment syntax in condition bodies and tests

#Local variable assignment in a conditional body
if false
  l = 1
end

p l #Output: nil
p w #Output: undefined local variable

#Assignment in a conditional test
if x = 1 # Output: "warning..."; condition will always be true
  puts 'Hi'
end

z = false

if x = z #No warning; x = z may or may not succeed as conditional test
  puts 'Hi'
end

name = "Matt T. Carlson"
if m = /ar/.match(name) #The variable m will be nil if there's no match.
  puts 'Found a match!'
  print "Here's the unmatched start of the string: "
  puts m.pre_match
  print "Here's the unmatched end of the string: "
  puts m.post_match
else
  puts "No match"
end

#Probably better just to do:
m = /ar/.match(name)
if m
  # etc.
end

#6.1.3 case statements
print "Exit the program? (yes or no):"
answer = gets.chomp #Chomps off trailing newline char on input string
case answer
when 'yes'
  puts "Good-bye!"
when "no"
  puts "OK we'll continue"
else
  puts "That's an unknown answer; assuming you meant 'no'"
end
puts "Continuing with program"

#More than one possible match on a single when
case answer
when 'y', 'yes' # comma acts as an "or" operator
  puts 'goodbye'
end

#How when works
#Case statement translated into threequal terms
if "yes" === answer
  puts "Goodbye"
  exit
elsif "no" === answer
  puts 'okay we will continue'
else
  puts "That's an unknown answer-assuming you meant 'no'"
end

#Case/when logic is thus really object === other_object logic in disguise;

#Programming objects' case statement behavior
#6.2 Implementing case statement behavior for the Ticket class
class Ticket
  attr_accessor :venue, :date

  def initialize(venue, date)
    @venue = venue
    @date = date
  end

  def ===(other_ticket)
    @venue == other_ticket.venue
  end
end

ticket1 = Ticket.new('Town Hall', '07/08/13')
ticket2 = Ticket.new('Conference Center', '07/08/13')
ticket3 = Ticket.new("Town Hall", "08/09/13")

case ticket1
when ticket2 #Hidden call to ticket2.===(ticket1) => false
  puts "Ticket one is at #{ticket1.venue} , which is the same location as ticket2"
when ticket3 #Hidden call to ticket3.===(ticket1) => true
  puts "Ticket one is at #{ticket1.venue} , which is the same location as ticket3"
else
  puts "no match"
end
#Output: "Ticket one is at Town Hall , which is the same location as ticket3"

# The simple case truth test
first_name = "Matt"
last_name = "Carlson"
case #if case has no arguments, first when clause to be true runs
when first_name == "Matt", last_name == "Carlson"
  puts "You might be Matt Carlson"
when Time.now.wday == 5
  puts "You're not Matt Carlson, but at least it's Friday"
else
  puts "You're not Matt Carlson, and it's not Friday"
end

# Return value of case statements
puts case # whichever when condition runs will return as the argument
  when first_name == "Matt", last_name == "Carlson"
    "You might be Matt Carlson"
  when Time.now.wday == 5
    "You're not Matt Carlson, but at least it's Friday"
  else
    "You're not Matt Carlson, and it's not Friday"
  end
