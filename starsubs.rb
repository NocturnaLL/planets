require File.expand_path('../star.rb', __FILE__)
class DwarfStar < Star
  def initialize()
    super(0.0006,rand(8..15),rand(30..90),2**20,rand(2**3..2**64)-1,rand(2**3..2**64)-1,rand(2**3..2**64)-1)

  end

end

class GiantStar < Star
  def initialize()
    super(0.0005,rand(5..10),rand(100..250),2**30,rand(2**3..2**64)-1,rand(2**3..2**64)-1,rand(2**3..2**64)-1)

  end

end

class MediumStar < Star
  def initialize()
    super(0.0009,rand(2..9),rand(60..140),2**25,rand(2**3..2**64)-1,rand(2**3..2**64)-1,rand(2**3..2**64)-1)
  end

  

end
