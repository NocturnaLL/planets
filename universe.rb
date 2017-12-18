require File.expand_path('../starsubs.rb', __FILE__)
require File.expand_path('../probe.rb', __FILE__)
class Universe
attr_accessor :numStar
  def initialize(numStar=2**10)
    @dwarfStars = []
    @giantStars = []
    @mediumStars = []
    @numStar = numStar
    @dwarfRocky = 0
    @dwarfHabitable = 0
    @dwarfGaseous = 0
    @giantRocky = 0
    @giantHabitable = 0
    @giantGaseous = 0
    @mediumRocky = 0
    @mediumGaseous = 0
    @mediumHabitable = 0
    @intLifeDwarf = 0
    @intLifeGiant = 0
    @intLifeMedium = 0
    @allStars = []
    @lifeFound = false
    @probe = Probe.new
    @startingX = @probe.coor_x
    @startingY = @probe.coor_y
    @startingZ = @probe.coor_z
    @notFound = true
    while @numStar>0
      random = rand(1..3)
      if ( random == 1 )
        @dwarfStars.push( DwarfStar.new)

      elsif (random == 2)
        @giantStars.push( GiantStar.new )

      elsif (random ==3)
        @mediumStars.push( MediumStar.new )
      end
      @numStar = @numStar -1
    end
    @allStars = @dwarfStars + @giantStars + @mediumStars

    puts "Total number of stars in my universe: #{numStar}"
    countPlanets
    printStars
    travelUniverse
    printProbe
  end

  def countPlanets
    #count planets in each Star.
    @dwarfStars.each do |d|
      @dwarfRocky = @dwarfRocky + d.get_rockyPlanets.length
      @dwarfHabitable = @dwarfHabitable + d.get_habitablePlanets.length
      @dwarfGaseous = @dwarfGaseous + d.get_gaseousPlanets.length
      d.get_habitablePlanets.each do |habitable|
        if (habitable.intlife == 1)
          @intLifeDwarf = @intLifeDwarf + 1
        end
      end
    end



    @giantStars.each do |g|
      @giantRocky = @giantRocky + g.get_rockyPlanets.length
      @giantGaseous = @giantGaseous + g.get_gaseousPlanets.length
      @giantHabitable = @giantHabitable + g.get_habitablePlanets.length
      g.get_habitablePlanets.each do |habitable|
        if (habitable.intlife == 1)
          @intLifeGiant = @intLifeGiant + 1
        end
      end
    end



    @mediumStars.each do |m|
      @mediumRocky = @mediumRocky + m.get_rockyPlanets.length
      @mediumGaseous = @mediumGaseous + m.get_gaseousPlanets.length
      @mediumHabitable = @mediumHabitable + m.get_habitablePlanets.length
      m.get_habitablePlanets.each do |habitable|
        if (habitable.intlife == 1)
          @intLifeMedium = @intLifeMedium + 1
        end
      end
    end


  end

  def printStars
    #prints how many starts and planets
    puts "There are #{@dwarfStars.length} Dwarf Stars with:"
    puts "  #{@dwarfGaseous} Gaseous Planets"
    puts "  #{@dwarfRocky} Dwarf Planets"
    puts "  #{@dwarfHabitable} Habitable Planets"
    puts "  #{@intLifeDwarf} Planets with intelligent Life"
    puts " "
    puts " "
    puts "There are #{@giantStars.length} Giant Stars with:"
    puts "  #{@giantGaseous} Gaseous Planets"
    puts "  #{@giantRocky} Dwarf Planets"
    puts "  #{@giantHabitable} Habitable Planets"
    puts "  #{@intLifeGiant} Planets with intelligent Life"
    puts " "
    puts " "
    puts "There are #{@mediumStars.length} Medium Stars with:"
    puts "  #{@mediumGaseous} Gaseous Planets"
    puts "  #{@mediumRocky} Dwarf Planets"
    puts "  #{@mediumHabitable} Habitable Planets"
    puts "  #{@intLifeMedium} Planets with intelligent Life"
    puts ""
    puts "----------------------"
    puts "----------------------"
    puts ""
  end

  def printProbe
    #calls probes printings
    @probe.printFindings
  end

  def travelUniverse
    #algorithm for probe
    #I decided to put this method to universe class since I don't want to initialize universe object inside the probe class
    #I discussed that with Professor Moore he said ok, you can put algorithms method into universe class.
    @allStars.sort! { |a, b|  Math.sqrt((a.coor_x-@probe.coor_x)**2 + (a.coor_y-@probe.coor_y)**2 + (a.coor_z - @probe.coor_z)**2) <=> Math.sqrt((b.coor_x-@probe.coor_x)**2 + (b.coor_y-@probe.coor_y)**2 + (b.coor_z - @probe.coor_z)**2) }
    @allStars.each do |stars|
      if (@probe.fuel>1 and !@lifeFound)
        @probe.totalTravel = @probe.totalTravel + Math.sqrt((stars.coor_x-@probe.coor_x)**2 + (stars.coor_y-@probe.coor_y)**2 + (stars.coor_z - @probe.coor_z)**2)
        @probe.fuel = @probe.fuel - (Math.sqrt((stars.coor_x-@probe.coor_x)**2 + (stars.coor_y-@probe.coor_y)**2 + (stars.coor_z - @probe.coor_z)**2))/400
        @probe.fuel = @probe.fuel + stars.recharge
        @probe.coor_x = stars.coor_x
        @probe.coor_y = stars.coor_y
        @probe.coor_z = stars.coor_z
        @probe.numberOfStars = @probe.numberOfStars + 1
        @probe.numberOfPlanets = @probe.numberOfPlanets + stars.get_number_of_planets
      end
      if (@probe.fuel<1 and !@lifeFound)
        @probe.fuel=0
        puts ""
        puts "You run out of fuel"
        puts ""
        break
      end
      stars.get_habitablePlanets.each do |habitable|
        if (habitable.intlife == 1 and @notFound)
          @lifeFound = true
          puts "Found Life at #{habitable.id}"
          puts "Travelling back to station..."
          @probe.totalTravel + Math.sqrt((@probe.coor_x - @startingX)**2 + (@probe.coor_y - @startingY)**2 + (@probe.coor_z - @startingZ)**2)
          @probe.fuel = @probe.fuel - (Math.sqrt((@probe.coor_x - @startingX)**2 + (@probe.coor_y - @startingY)**2 + (@probe.coor_z - @startingZ)**2))/500
          @notFound = false
        end
      end
    end
  end
end
