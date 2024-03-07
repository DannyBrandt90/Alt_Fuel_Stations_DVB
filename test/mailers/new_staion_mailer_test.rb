require "test_helper"

class NewStaionMailerTest < ActionMailer::TestCase
  test "residential_station_email" do
    mail = NewStaionMailer.residential_station_email
    assert_equal "Residential station email", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
