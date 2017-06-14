# test/sms/sms_test.rb
require 'httparty'
require 'movile'
require 'movile/sms'

class SmsTest < Minitest::Test
  def setup
    @sms = SMS.new(username: ENV['MOVILE_USER'],
                   access_token: ENV['MOVILE_TOKEN'])
  end

  def test_method_send
    assert_equal(true, @sms.methods.include?(:send_message))
  end

  def test_method_status
    assert_equal(true, @sms.methods.include?(:status_message))
  end

  def test_invalid_number
    invalid_number = '123'
    invalid_text = ('a' * 159)
    assert_raises 'Not Valid' do
       @sms.send_message(invalid_number, invalid_text)
    end
  end

  def test_invalid_text
    invalid_number = '5511999999999'
    invalid_text = ('a' * 161)
    assert_raises 'Not Valid' do
       @sms.send_message(invalid_number, invalid_text)
    end
  end

  def test_status_message_param
    assert_raises ArgumentError do
      @sms.status_message #no_params
    end
  end

  def test_base_url
    assert_kind_of String, SMS::BASE_API_URL
  end

  def test_empty_base_url
    refute_empty SMS::BASE_API_URL
  end

  def test_empty_report_url
    refute_empty SMS::REPORT_API_URL
  end

  def test_report_url
    assert_kind_of String, SMS::REPORT_API_URL
  end

  def test_instance_sms
    assert_instance_of(SMS, @sms)
  end

  def test_send_invalid_username_or_token
    @sms_invalid = SMS.new(username: 'Some User', access_token: 'Any Token')
    assert_nil(@sms_invalid.send_message('5511999999999', 'only a test'))
  end
end
