require 'test_helper'

class AccountsControllerTest < ActionDispatch::IntegrationTest
  test "should get destroy" do
    get accounts_destroy_url
    assert_response :success
  end

end
