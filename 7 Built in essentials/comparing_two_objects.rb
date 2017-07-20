#7.6.1 Equality tests
string1 = 'text'
string2 = 'text'
string1 == string2 #=> true
string1.eql?(string2) #=> true
string1.equal?(string2) #=> false

#7.6.2 Comparisons and the Comparable module

#Example of a class that mixes in the Comparable module
class Bid
  include Comparable
  attr_accessor :estimate

  def <=>(other_bid)
    if self.estimate < other_bid.estimate
      -1
    elsif self.estimate > other_bid.estimate
      1
    else
      0
    end
  end
end

#This can be shortened to:
class Bid
  include Comparable
  attr_accessor :estimate

  def <=>(other_bid)
    self.estimate <=> other_bid.estimate
  end
end

bid1 = Bid.new
bid2 = Bid.new
bid1.estimate = 100
bid2.estimate = 105
bid1 < bid2 #=> true
bid3 = Bid.new
bid3.estimate = 103
bid3.between?(bid1, bid2) #=> true
