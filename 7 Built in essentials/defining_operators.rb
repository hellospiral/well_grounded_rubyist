# Defining operators by defining methods
class Account
  attr_accessor :balance

  def initialize(amount=0)
    @balance = amount
  end

  def +(x)
    @balance += x
  end

  def -(x)
    @balance -= x
  end

  def to_s
    @balance.to_s
  end
end
acc = Account.new(20)
acc -= 5 #subtract from the account
acc #Output: 15

#Customizing unary operators
class Banner
  def initialize(text)
    @text = text
  end

  def to_s
    @text
  end

  def +@
    @text.upcase
  end

  def -@
    @text.downcase
  end

  def !
    @text.reverse
  end
end

banner = Banner.new("Eat at David's")
puts banner #Output: Eat at David's
puts +banner #Output: EAT AT DAVID'S
puts -banner #Output eat at david's
puts !banner #Output: s'divaD ta taE
puts (not banner) #Output: s'divaD ta taE
