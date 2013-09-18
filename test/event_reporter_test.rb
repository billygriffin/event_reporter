require "minitest"
require "minitest/autorun"
require "./event_reporter"
require "csv"

class EventManagerTest < Minitest::Test

  def test_it_exists
    er = EventReporter.new
    assert_kind_of EventReporter, er
  end

end