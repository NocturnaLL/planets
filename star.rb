require File.expand_path('../planet.rb', __FILE__)
require File.expand_path('../planetsub.rb', __FILE__)
class Star
  attr_accessor :chances_of_life, :range_of_planets, :goldilocks_zone, :recharge
  attr_reader :coor_x, :coor_y, :coor_z

  def initialize(chances_of_life, range_of_planets, goldilocks_zone, recharge, coor_x, coor_y, coor_z)

    @chances_of_life = chances_of_life
    @range_of_planets = range_of_planets
    @goldilocks_zone = goldilocks_zone
    @recharge = recharge
    @coor_x = coor_x
    @coor_y = coor_y
    @coor_z = coor_z
    @rockyPlanets = []
    @gaseousPlanets = []
    @habitablePlanets = []
    @randomLife = rand(1..10000)
    @totalPlanets = []

    t = range_of_planets
    while t > 0
      random = rand(1..3)
      if(random==1)
        @rockyPlanets.push(RockyPlanet.new)
      elsif(random==2)
        @gaseousPlanets.push(GaseousPlanet.new)
      elsif(random==3)
        r = HabitablePlanet.new
        if(chances_of_life*10000>=@randomLife)
          if (r.distance <= @goldilocks_zone)
            r.intlife = 1
          end
        end
        @habitablePlanets.push(r)
      end

      t = t - 1
    end
  end

  def get_rockyPlanets
    #returns rockyPlanets
    @rockyPlanets
  end

  def get_gaseousPlanets
    #returns gaseousPlanets
    @gaseousPlanets
  end

  def get_habitablePlanets
    #returns habitablePlanets
    @habitablePlanets
  end

  def get_number_of_planets
    #returns number of planets
    @totalPlanets = @rockyPlanets+@gaseousPlanets+@habitablePlanets
    @totalPlanets.length
  end

end
