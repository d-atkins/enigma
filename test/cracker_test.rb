require_relative "test_helper"
require "./lib/cracker"
require 'time'
require 'mocha/minitest'

class CrackerTest < Minitest::Test

  def setup
    dummy_time = Time.parse("2018-10-29")
    Time.stubs(:now).returns(dummy_time)
    @cracker = Cracker.new
  end

  def test_it_exists
    assert_instance_of Cracker, @cracker
  end

  def test_it_can_get_todays_date
    assert_equal "291018", @cracker.today
  end

  def test_it_can_set_offset
    assert_equal ["6", "3", "2", "4"], @cracker.offset("291018")
  end

  def test_it_can_get_reverse_shifts
    ciphertext = "vjqtbeaweqihssi"

    assert_equal [14, 5, 5, 8], @cracker.reverse_shifts(ciphertext)
  end

  def test_it_can_get_root_keys
    shifts = [14, 5, 5, 8]
    offset = @cracker.offset("291018")

    assert_equal [8, 2, 3, 4], @cracker.root_keys(shifts, offset)
  end

  def test_it_can_do_a_full_shift_on_a_key
    assert_equal 30, @cracker.full_shift(3)
  end

  def test_it_can_convert_key_to_string
    assert_equal "03", @cracker.key_to_string(3)
    assert_equal "42", @cracker.key_to_string(42)
    assert_equal "00", @cracker.key_to_string(0)
  end

  def test_it_can_get_potential_keys
    root_keys = [8, 2, 3, 4]
    expected = [
      ["08", "35", "62", "89"],
      ["02", "29", "56", "83"],
      ["03", "30", "57", "84"],
      ["04", "31", "58", "85"]
    ]

    assert_equal expected, @cracker.potential_keys(root_keys)
  end

  def test_it_can_get_256_potential_key_combinations
    root_keys = [8, 2, 3, 4]
    potential_keys = @cracker.potential_keys(root_keys)

    assert_equal 256, @cracker.all_combinations(potential_keys).length
  end

  def test_it_can_determine_if_an_array_chains_together
    assert_equal true, @cracker.chains_together?(["08", "83", "30", "04"])
    assert_equal false, @cracker.chains_together?(["08", "73", "30", "04"])
  end

  def test_it_can_get_an_array_of_valid_keys
    root_keys = [8, 2, 3, 4]
    potential_keys = @cracker.potential_keys(root_keys)
    all_potential = @cracker.all_combinations(potential_keys)

    assert_equal [["08", "83", "30", "04"]], @cracker.valid_keys(all_potential)
  end

  def test_it_can_caesar_shift
    assert_equal "m", @cracker.caesar_shift("l", 1)
    assert_equal "b", @cracker.caesar_shift("Z", 3)
    assert_equal " ", @cracker.caesar_shift("a", -1)
    assert_equal "q", @cracker.caesar_shift("Q", 54)
    assert_equal ",", @cracker.caesar_shift(",", 3)
    assert_equal "!", @cracker.caesar_shift("!", -7)
    assert_equal "d", @cracker.caesar_shift("z", 815)
    assert_equal "g", @cracker.caesar_shift("g", 0)
  end

  def test_it_can_report_info
    expected = {
      decryption: "ai",
      key: "02715",
      date: "040895"
    }

    assert_equal expected, @cracker.report(:decryption, "ai", "02715", "040895")
  end

  def test_it_can_derive_a_key_from_keys
    assert_equal "08304", @cracker.derive_key(["08", "83", "30", "04"])
  end

  def test_it_can_prepare_key
    assert_equal ["08304"], @cracker.prepare_keys("vjqtbeaweqihssi", "291018")
  end

  def test_it_can_crack
    expected = {
      decryption: "hello world end",
      key: "08304",
      date: "291018"
    }

    assert_equal expected, @cracker.crack("vjqtbeaweqihssi", "291018")
  end

  def test_it_can_crack_with_no_date_argument
    expected = {
      decryption: "hello world end",
      key: "08304",
      date: "291018"
    }

    assert_equal expected, @cracker.crack("vjqtbeaweqihssi")
  end

  def test_it_can_find_multiple_keys_with_crack
    expected = {
      decryption: "?!?!?! end",
      key: ["63093", "90366"],
      date: "040895"
    }

    assert_equal expected, @cracker.crack("?!?!?!kvxg", "040895")
  end
end
