class Probe
  attr_accessor :coor_x, :coor_y, :coor_z, :totalTravel, :idIntPlanet, :numberOfStars, :numberOfPlanets, :fuel
  def initialize(coor_x = rand(2**3..2**64)-1, coor_y = rand(2**3..2**64)-1, coor_z = rand(2**3..2**64)-1, fuel = 2**64)
    @coor_x = coor_x
    @coor_y = coor_y
    @coor_z = coor_z
    @totalTravel = 0
    @idIntPlanet = ''
    @numberOfStars = 0
    @numberOfPlanets = 0
    @fuel = fuel
  end

  def printFindings()
    #prints probs explored planets
    puts "Your origin was (#{@coor_x}, #{@coor_y}, #{@coor_z})"
    puts "  Traveled #{@totalTravel} miles"
    puts "  You have #{@fuel} remaining"
    puts "  Visited #{@numberOfStars} stars"
    puts "  Explored #{@numberOfPlanets} planets"

  end
end
