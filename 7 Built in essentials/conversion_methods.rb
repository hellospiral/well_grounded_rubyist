# 7.4 Built-in and custom to_*(conversion) methods
obj = Object.new
puts obj
def obj.to_s
  "I'm an object!"
end
puts obj #Output: "I'm an object!"
puts "My object says #{obj}"

#7.4.2 Array conversion
arr = [1,2,3]
arr2 = [4,5,6]
arr3 = [7,8,9]
list = [*arr, *arr2, *arr3] #=> [1, 2, 3, 4, 5, 6, 7, 8, 9]
list.push(*[10,11,12]) #=> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

def combine_names(first, last)
  first + ' ' + last
end
names = ["Johnny", "Boy"]
puts combine_names(*names) #Output: Johnny Boy

#7.4.3 Numerical conversion
n = '2'
puts n * 3 #=> '222'
'mike'.to_i #=> 0
"13".to_i #=> 13
"421InsanePerson12isGreat09".to_i #=> 421
"421InsanePerson12isGreat09".to_f #=> 421.0
"123.32".to_f #=> 123.32
"1hello.42".to_f #=> 1.0
'05xys'.to_f #=> 5.0
'-5xys'.to_f #=> -5.0

#Stricter conversions
Integer("234") #=> 234
Integer("123abc") #=> ArgumentError: invalid value for Integer(): "123abc"
Float("3") #=> 3.0
Float('-3xyz') #ArgumentError

#7.4.4 Role-playing to_* methods
class Person
  attr_accessor :name
  def to_str
    name
  end
end
matt = Person.new
matt.name = "Matt"
puts "Matt is named " + matt + "."

#Array role-playing with to_ary
class Person
  attr_accessor :name, :age, :email
  def to_ary
    [name, age, email]
  end
end
matt = Person.new
matt.name = "Matt"
matt.age = 34
matt.email = "matt@exmpel.com"
array = []
array.concat(matt)
array #=> ["Matt", 34, "matt@exmpel.com"]
