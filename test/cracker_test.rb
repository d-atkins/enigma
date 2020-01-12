require_relative "test_helper"
require "./lib/cracker"

class CrackerTest < Minitest::Test

  def test_it_exists
    cracker = Cracker.new

    assert_instance_of Cracker, cracker
  end
end
