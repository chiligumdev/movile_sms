# test/sms/sms_test.rb
require 'minitest/autorun'
require './test/test_helper'

class SmsTest < Minitest::Test
  def sms_exist
    assert Movile::Sms
  end
end
