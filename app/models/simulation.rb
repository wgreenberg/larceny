class Simulation < ApplicationRecord
  def self.current_time
    Simulation.last.sim_time
  end

  def self.next_time
    Simulation.current_time + 1
  end

  def self.advance
    sim = Simulation.last
    sim.sim_time += 1
    sim.save
  end
end
