# 5.1 Examining self
class C
  puts "Just started class C:"
  puts self #Output: C
  module M
    puts "Nested module C::M:"
    puts self #Output: C:M
  end
  puts "Back in the outer level of C:"
  puts self #Output: C
end

class C
  def C.no_dot
    puts 'As long as self is C, you can call this method with no dot'
  end
  no_dot
end
C.no_dot

class C
  def x
    puts 'This is method "x"'
  end
  def y
    puts 'This is method "y", about to call x without a dot'
    x
  end
end

# 5.2 Composing whole name from values, using method calls on implicit self

class Person
  attr_accessor :first_name, :middle_name, :last_name

  def whole_name
    n = first_name + " "
    n << "#{middle_name} " if middle_name
    n << last_name
  end
end

david = Person.new
david.first_name = "David"
david.last_name = "Black"

puts "David's whole name: #{david.whole_name}"

david.middle_name = "Alan"
puts "David's new whole name: #{david.whole_name}"

# 5.3 Demonstrating the relationship between instance variables and self
class C
  puts "Just inside the class definition block. Here's self:"
  p self
  @v = "I am an instance variable at the top level of a class body."
  puts "And here's the instance variable @v, belonging to #{self}"
  p @v

  def show_var
    puts "Inside an instance method definition block. Here's self:"
    p self
    puts "And here's the instance variable @v, belonging to #{self}"
    p @v
  end
end
c = C.new
c.show_var
