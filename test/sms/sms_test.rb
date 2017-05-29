#test/sms/sms_test.rb
require './test/test_helper'

class SmsTest < Minitest::Test

  def sms_exist
    assert MovileSms::Sms
  end
end