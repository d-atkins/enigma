require_relative 'test_helper'
require './lib/enigma'
require 'time'
require 'mocha/minitest'

class EnigmaTest < Minitest::Test

  def setup
    dummy_time = Time.parse("2020-1-12")
    Time.stubs(:now).returns(dummy_time)
    @enigma = Enigma.new
  end

  def test_it_exists
    assert_instance_of Enigma, @enigma
  end

  def test_it_has_attributes
    assert_instance_of Encoder, @enigma.encoder
    assert_instance_of Decoder, @enigma.decoder
    assert_instance_of Cracker, @enigma.cracker
  end

  def test_it_can_encrypt
    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }

    assert_equal expected, @enigma.encrypt("hello world", "02715", "040895")
  end

  def test_it_can_encrypt_with_no_date_argument
    expected = {
      encryption: "nib udmcxpu",
      key: "02715",
      date: "120120"
    }

    assert_equal expected, @enigma.encrypt("hello world", "02715")
  end

  def test_it_can_encrypt_with_no_key_or_date_argument
    @enigma.encoder.stubs(:random_key).returns("02715")
    expected = {
      encryption: "nib udmcxpu",
      key: "02715",
      date: "120120"
    }

    assert_equal expected, @enigma.encrypt("hello world")
  end

  def test_it_can_decrypt
    expected = {
      decryption: "hello world",
      key: "02715",
      date: "040895"
    }

    assert_equal expected, @enigma.decrypt("keder ohulw", "02715", "040895")
  end

  def test_it_can_decrypt_with_no_date_argument
    expected = {
      decryption: "hello world",
      key: "02715",
      date: "120120"
    }

    assert_equal expected, @enigma.decrypt("nib udmcxpu", "02715")
  end

  def test_it_can_crack
    expected = {
      decryption: "hello world end",
      key: "08304",
      date: "291018"
    }

    assert_equal expected, @enigma.crack("vjqtbeaweqihssi", "291018")
  end

  def test_it_can_crack_with_no_date_argument
    expected = {
      decryption: "hello world end",
      key: "02715",
      date: "120120"
    }

    assert_equal expected, @enigma.crack("nib udmcxpuokru")
  end
end
