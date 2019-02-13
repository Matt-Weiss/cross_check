require './test/test_helper'

class StatTrackerTest < Minitest::Test

  def test_it_exists
    stat_tracker = StatTracker.new

    assert_instance_of StatTracker, stat_tracker
  end
end
