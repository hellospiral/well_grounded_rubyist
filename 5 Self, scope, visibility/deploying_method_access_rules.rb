# 5.3 Deploying method-access rules

#5.8 Baker and other baking-domain classes
class Cake
  def initialize(batter)
    @batter = batter
    @baked = true
  end
end

class Egg
end

class Flour
end

class Baker
  def bake_cake
    @batter = [] #array of objects
    pour_flour
    add_egg
    stir_batter
    return Cake.new(@batter) # Returns new cake object
  end

  def pour_flour
    @batter.push(Flour.new) # Adds element (ingredient) to @batter
  end

  def add_egg
    @batter.push(Egg.new)
  end

  def stir_batter
  end

  private :pour_flour, :add_egg, :stir_batter
end

# Private setter (=) methods
class Dog
  attr_reader :age, :dog_years

  def dog_years=(years)
    @dog_years = years
  end

  def age=(years)
    @age = years
    self.dog_years = years * 7
  end

  private :dog_years=
end

rover = Dog.new
rover.age = 10
rover.dog_years #Output: 70

# Protected methods

# 5.9 Example of a protected method and its use
class C
  def initialize(n)
    @n = n
  end

  def n
    @n
  end

  def compare(c)
    if c.n > n
      puts "The other object's n is bigger."
    else
      puts "The other object's n is the same or smaller"
    end
  end

  protected :n
end

c1 = C.new(100)
c2 = C.new(101)
c1.compare(c2) # c1 has to ask the other object (c2) to execute its n method, so n can't be private
# With n protected rather than private, c1 can ask c2 to execute n, becuase c1 and c2 are both instances of the same class
