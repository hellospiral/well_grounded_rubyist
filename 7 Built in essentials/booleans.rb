#True and false as states
if (class Myclass; end)
  puts "Empty class definition is true"
else
  puts "Empty class definition is false"
end
#Output: Empty class definition is false

if (class MyClass; 1; end)
  puts "Class defiition with the number 1 in it is true!"
else
  puts "Class definitio with the number 1 in it is false!"
end
#Output: Class defiition with the number 1 in it is true!

if (def m; return false; end)
  puts "Method definition is true!"
else
  puts "Method definition is false!"
end
#Output: "Method definition is true!"

if "string"
  puts "strings are true"
else
  puts "strings are false"
end
#Output: "strings are true"

class Myclass; end #=> nil
class MyClass; 1; end #=> 1
def m; return false; end #=> :m
"string" #=> "string"
100 > 50 #=> true
(100 > 50).class #=> TrueClass
