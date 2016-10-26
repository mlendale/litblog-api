require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = FactoryGirl.create(:user)
  end
end
