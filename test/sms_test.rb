# test/sms/sms_test.rb
require 'httparty'
require 'movile/sms'
require 'movile'

class SmsTest < Minitest::Test
  def setup
    @sms = Movile::SMS.new(username: ENV['MOVILE_USER'],
                           access_token: ENV['MOVILE_TOKEN'])
    @sms_invalid = Movile::SMS.new(username: 'User', access_token: 'Token')
  end

  def test_method_send
    assert_equal(true, @sms.methods.include?(:send_message))
  end

  def test_method_status
    assert_equal(true, @sms.methods.include?(:status_message))
  end

  def test_method_send_bulk
    assert_equal(true, @sms.methods.include?(:send_bulk_message))
  end

  def test_invalid_number
    invalid_number = '123'
    valid_text = ('a' * 159)
    assert_raises 'Not Valid' do
      @sms.send_message(invalid_number, valid_text)
    end
  end

  def test_invalid_text
    valid_number = '5511999999999'
    invalid_text = ('a' * 161)
    assert_raises 'Not Valid' do
      @sms.send_message(valid_number, invalid_text)
    end
  end

  def test_status_message_param
    assert_raises ArgumentError do
      @sms.status_message # no_params
    end
  end

  def test_base_url
    assert_kind_of String, Movile::SMS::BASE_API_URL
  end

  def test_empty_base_url
    refute_empty Movile::SMS::BASE_API_URL
  end

  def test_empty_bulk_url
    refute_empty Movile::SMS::BULK_API_URL
  end

  def test_empty_report_url
    refute_empty Movile::SMS::REPORT_API_URL
  end

  def test_report_url
    assert_kind_of String, Movile::SMS::REPORT_API_URL
  end

  def test_bulk_url
    assert_kind_of String, Movile::SMS::BULK_API_URL
  end

  def test_instance_sms
    assert_instance_of(Movile::SMS, @sms)
  end

  def test_send_invalid_username_or_token
    assert_nil(@sms_invalid.send_message('5511999999999', 'only a test'))
  end

  def test_send_argument_error
    assert_raises ArgumentError do
      @sms_invalid.send_message('wrong number of params')
    end
  end
end
