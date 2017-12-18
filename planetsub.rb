require File.expand_path('../planet.rb', __FILE__)
require 'securerandom'
class RockyPlanet<Planet
  def initialize()
    identity = SecureRandom.uuid
    identity = 'r'+ identity
    super(identity)
  end
end

class GaseousPlanet<Planet
  def initialize()
    identity = SecureRandom.uuid
    identity = 'g'+ identity
    super(identity)
  end
end

class HabitablePlanet<Planet
  def initialize()
    identity = SecureRandom.uuid
    identity = 'h'+ identity
    super(identity)
  end
end
