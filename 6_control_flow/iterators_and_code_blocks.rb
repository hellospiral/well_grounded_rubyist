#6.3 Iterators and code blocks
# An iterator is a Ruby method that has an extra ingredient in its calling syntax: it expects you to provide it with a code block.

# Reimplementing loop in pure Ruby
def my_loop
  while true
    yield
  end
end

n = 1
my_loop do
  puts n
  n += 1
  break if n > 9
end

# The difference between a method call with a block and a method call with- out a block comes down to whether or not the method can yield.

# Curly braces vs do/end

array = [1,2,3] #=> [1, 2, 3]
array.map {|n| n * 10} #=> [10, 20, 30]
array.map do |n| n * 10 end #=> [10, 20, 30]
puts array.map {|n| n * 10 }
#10
#20
#30
puts array.map do |n| n * 10 end
#<Enumerator:0x007fb5e0a71f78>

#The reason is that the precedence is different. The first puts statement is interpreted like this:
puts(array.map {|n| n * 10 })
#The second is interpreted like this:
puts(array.map) do |n| n * 10 end #puts ignores the block

#6.3.5 Implementing times
5.times {|i| puts "I'm on iteration #{i}"}

class Integer
  def my_times
    c = 0
    until c == self
      yield(c)
      c += 1
    end
    self
  end
end

5.my_times {|i| puts "I'm on iteration #{i}"}

#6.3.6 Each
array = [1,2,3,4,5]
array.each {|e| puts "The block just handled #{e}. "}

# Implementing each
class Array
  def my_each
    c = 0
    until c == size
      yield(self[c]) #Use [] to get current array element
      c += 1
    end
    self
  end
end

array = [1,2,3,4,5]
array.my_each { |e| puts "The block just got handed #{e}." }

# 6.3.7 From each to map
names = ["matt", "thomas", 'carlson']
names.map {|name| name.upcase } #=> ["MATT", "THOMAS", "CARLSON"]

class Array
  def my_map
    c = 0
    acc = []
    until c == size
      acc << yield(self[c]) #Captures return value from block in acc array
      c += 1
    end
    acc #Returns acc array
  end
end

names.my_map {|name| name.upcase } #=> ["MATT", "THOMAS", "CARLSON"]

# Building map on top of each
class Array
  def my_each
    c = 0
    until c == size
      yield(self[c]) #Use [] to get current array element
      c += 1
    end
    self
  end

  def my_map
    acc = []
    my_each { |e| acc << yield(e) } # allow my_each to do the iterating
    acc
  end
end

# 6.3.8 Block parameters and variable scope
def args_unleashed(a, b=1, *c, d, e)
  puts "Arguments:"
  p a,b,c,d,e
end
args_unleashed(1,2,3,4,5)
#Output:
# Arguments:
# 1
# 2
# [3]
# 4
# 5

# Is equivalent to:
def block_args_unleashed
  yield(1,2,3,4,5)
end

block_args_unleashed do |a, b=1, *c, d, e|
  puts "Arguments:"
  p a,b,c,d,e
end
#Output:
# Arguments:
# 1
# 2
# [3]
# 4
# 5

def block_scope_demo
  x = 100
  1.times do #Single iteration serves to create code block context
    puts x # x inside the block is the same as the x that existed already:
  end
end
block_scope_demo #Output: 100

def block_scope_demo_2
  x = 100
  1.times do
    x = 200 # Same x
  end
  puts x
end
block_scope_demo #Output: 200

def block_local_parameter
  x = 100
  [1,2,3].each do |x| # Scope change; different x
    puts "parameter x is #{x}"
    x += 10
    puts "Reassigned to x in block; it's now #{x}"
  end
  puts "Outer x is still #{x}"
end
block_local_parameter
#Outut:
# parameter x is 1
# Reassigned to x in block; it's now 11
# parameter x is 2
# Reassigned to x in block; it's now 12
# parameter x is 3
# Reassigned to x in block; it's now 13
# Outer x is still 100

def block_local_variable
  x = "Original x!"
  3.times do |i;x|
    x = i
    puts "x in the block is now #{x}"
  end
  puts "x after the block ended is #{x}"
end
block_local_variable
#Output:
# x in the block is now 0
# x in the block is now 1
# x in the block is now 2
# x after the block ended is Original x!

#The variables listed after the semicolon aren’t considered block parameters; they don’t get bound to anything when the block is called. They’re reserved names—names you want to be able to use as temporary variables inside the block without having to check for name collisions from outside the block.
