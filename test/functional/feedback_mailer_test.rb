require 'test_helper'

class FeedbackMailerTest < ActionMailer::TestCase
  test "new_platform_suggestion_alert" do
    mail = FeedbackMailer.new_platform_suggestion_alert
    assert_equal "New platform suggestion alert", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "new_feedback_alert" do
    mail = FeedbackMailer.new_feedback_alert
    assert_equal "New feedback alert", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
