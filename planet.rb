class Planet
  attr_accessor :id, :distance, :intlife

  def initialize(id ='p', distance=rand(0..300))
    @id = id
    @distance = distance
    @intlife = 0
  end

end
