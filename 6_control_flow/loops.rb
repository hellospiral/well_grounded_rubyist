#Unconditional looping with the loop method
n = 1
loop do
  n += 1
  break if n > 9
end

n = 1
loop do
  n += 1
  p n
  next unless n == 10
  break # control falls through to the break statement only if n == 10 is true, otherwise the 'next' is executed and it goes to begenning of loop
end

#Conditional looping with while and until
n=1
while n < 11
  puts n
  n=n+1
end
puts "Done!"

#Putting while at the end
n = 10
while n < 10
  puts n #this never executes
end

n = 10
begin
  puts n #Output: 10
end while n < 10

#While and until as modifiers
n = 1
n += 1 until n == 10
p "We've reached 10!"

a = 1
a += 1 until true #never runs because true is already true

a = 1
begin
  a += 1 # runs once
end until true

#Looping based on list of values
celsius = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100]
for c in celsius
  print "Celsius: #{c} ", "Farenheit: #{(c * 1.8) + 32}"
  puts ''
end
