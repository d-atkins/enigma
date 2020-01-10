require_relative "test_helper"
require "./lib/enigma_cracker"

class EnigmaCrackerTest < Minitest::Test
  def test_it_exists
    cracker = EnigmaCracker.new

    assert_instance_of EnigmaCracker, cracker
  end
end
