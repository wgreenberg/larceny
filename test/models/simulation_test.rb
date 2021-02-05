require "test_helper"

class SimulationTest < ActiveSupport::TestCase
  test "current_time" do
    assert_equal Simulation.current_time, 3
  end

  test "advance" do
    assert_equal Simulation.current_time, 3
    Simulation.advance
    assert_equal Simulation.current_time, 4
  end
end
