#Listing an object's methods

str = "Plain string"
def str.shout
  self.upcase + '!!!'
end
str.shout
str.methods.sort
str.singleton_methods #=> [:shout]

str = "Another plain string"
module StringExtras
  def shout
    self.upcase + "!!!"
  end
end

class String
  include StringExtras
end
str.methods.include?(:shout) #=> true

#7.7.2 Querying class and module objects
String.instance_methods.sort
Enumerable.instance_methods.sort

# Filtered and selected method lists

#View a class's instance methods without those of its ancestors:
String.instance_methods(false).sort

#Other method-listing methods:
obj.private_methods
obj.public_methods
obj.protected_methods
obj.singleton_methods

# Classes and modules let you examine their instance methods:
MyClass.private_instance_methods
MyClass.protected_instance_methods
MyClass.public_instance_methods
