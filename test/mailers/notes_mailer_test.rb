require "test_helper"

class NotesMailerTest < ActionMailer::TestCase
  test "new_note_email" do
    mail = NotesMailer.new_note_email
    assert_equal "New note email", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
