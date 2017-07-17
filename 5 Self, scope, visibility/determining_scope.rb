
# scope of local variables
class C
  a = 1
  def local_a
    a = 2
    puts a
  end
  puts a
end

c = C.new
c.local_a

# 5.4 Reusing a variable name in nested local scopes
class C
  a = 5
  module M
    a = 4
    module N
      a = 3
      class D
        a = 2
        def show_a
          a = 1
          puts a
        end
        puts a #Output: 2
      end
      puts a #Output: 3
    end
    puts a #Output: 4
  end
  puts a #Output: 5
end

d = C::M::N::D.new
d.show_a #Output: 1

# 5.5 Demonstrating the generation of a new local scope per method call
class C
  def x(value_for_a, recurse=false)
    a = value_for_a
    print "Here's the inspect-string for 'self':"
    p self
    puts "And here's a:"
    puts a
    if recurse
      puts "Calling myself (recursion)..."
      x("Second value for a ")
      puts "Back after recursion; here's a:"
      puts a
    end
  end
end
c = C.new
c.x("First value for a", true)
# every call to x generates a new local scope, even though self doesn't change

# 5.2.4 Scope and resolution of constants
module M
  class C
    X = 2
    class D
      module N
        X = 1
      end
    end
  end
end

puts M::C::D::N::X # Output: 1
puts M::C::X # Output: 2

module M
  class C
    class D
      module N
        X = 1
      end
    end
    puts D::N::X # Output: 1
  end
end
# The constant is identified relative to the point of execution.

#Forcing an absolute constant path
class Violin
  attr_accessor :maker, :date

  class String
    attr_accessor :pith

    def initialize(pitch)
      @pitch = pitch
    end
  end

  def initialize(maker, date)
    @maker = maker
    @date = date
    @e = String.new("E")
    @a = String.new("A")
  end

  def history
    ::String.new(maker + " " + date) # Use the constant path separator :: (double colon) at the begenning of the class name to start search at top level
  end
end

strat = Violin.new('strativarius', '1700')

# 5.2.5 Class variable syntax, scope, and visibility

# 5.6 keeping track of car manufacturing statistics with class variables
class Car
  @@makes = []
  @@cars = {}
  @@total_count = 0

  attr_reader :make

  def self.total_count
    @@total_count
  end

  def self.add_make(make)
    unless @@makes.include?(make)
      @@makes << make
      @@cars[make] = 0
    end
  end

  def initialize(make)
    if @@makes.include?(make)
      puts "Creating a new #{make}"
      @make = make
      @@cars[make] += 1
      @@total_count += 1
    else
      raise "No such make: #{make}"
    end
  end

  def make_mates
    @@cars[self.make]
  end
end

Car.add_make("Honda")
Car.add_make("Ford")
h = Car.new("Honda")
f = Car.new("Ford")
h2 = Car.new("Honda")

puts "Counting cars of same make as h2..."
puts "There are #{h2.make_mates}."

puts "Counting total cars..."
puts "There are #{Car.total_count}."

x = Car.new("Brand X")

#5.7 Car with @@total_count replaced by instance variable @total_count
class Car
  @@makes = []
  @@cars = {}

  attr_reader :make

  def self.total_count
    @total_count ||= 0 #Initializes total_count to zero; does so conditionally using or-equals, so that on subsequent calls the value is simply returned
  end

  def self.total_count=(n)
    @total_count = n # Attribute-writer method, written as a class method so that the object whose instance variable is in use is the class object.
  end

  def self.add_make(make)
    unless @@makes.include?(make)
      @@makes << make
      @@cars[make] = 0
    end
  end

  def initialize(make)
    if @@makes.include?(make)
      puts "Creating a new #{make}"
      @make = make
      @@cars[make] += 1
      self.class.total_count += 1 #Increment the total count from inside the instance method initialize
    else
      raise "No such make: #{make}"
    end
  end

  def make_mates
    @@cars[self.make]
  end
end

class Hybrid < Car
end

Car.add_make("Honda")
Car.add_make("Ford")
h = Car.new("Honda")
f = Car.new("Ford")
h2 = Car.new("Honda")

h3 = Hybrid.new("Honda")
f2 = Hybrid.new("Ford")

Car.total_count #Output: 3
Hybrid.total_count #Output: 2

#Car and Hybrid classes now have their own instance variables
