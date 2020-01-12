require_relative "test_helper"
require './lib/crypto_tool'

class CryptoToolTest < Minitest::Test
  def test_it_exists
    crypto_tool = CryptoTool.new
    assert_instance_of CryptoTool, crypto_tool
  end
end
