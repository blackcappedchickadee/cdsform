require 'test_helper'

class InquiryFormControllerTest < ActionController::TestCase
  test "should get process_form" do
    get :process_form
    assert_response :success
  end

end
