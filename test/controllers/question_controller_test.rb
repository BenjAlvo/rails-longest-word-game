require 'test_helper'

class QuestionControllerTest < ActionDispatch::IntegrationTest
  test "should get letters" do
    get question_letters_url
    assert_response :success
  end

end
