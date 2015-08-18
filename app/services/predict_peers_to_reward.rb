class PredictPeersToReward
  attr_accessor :mentor, :location, :time
  def initialize(mentor, location, time)
    self.mentor = mentor
    self.location = location
    self.time = time
  end

  def predict(n=10)
    #TODO: build prediction engine; use location and time
    mentor.peers.limit(n).all
  end
end
