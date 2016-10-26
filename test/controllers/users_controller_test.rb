require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
	@user=FactoryGirl.create(:user)
  end	
	
  test 'creates user' do
    assert_difference -> { User.count } do
      post api_v1_users_path, params: {"data":{"type":"users","attributes":{"name":"test1","email":"test1@example.com","password":"123456","password_confirmation":"123456"}}}, as: :json_api
    end

    assert_response :created
    user_response=JSON.parse(response.parsed_body, symbolize_names: true)
    assert_equal(User.last.id.to_s, user_response[:data][:id])
  end
  
  test 'show user' do
    get api_v1_user_path(@user.name)
    assert_response :success
    user_response=JSON.parse(response.parsed_body, symbolize_names: true)
    assert_equal(@user.id.to_s, user_response[:data][:id])
  end
  
  #TODO
  test 'updates user' do
    #post api_v1_users_path, params: {"data":{"id":@user.id,"type":"users","attributes":{"name":"test2","email":"test1@example.com","password":"","password_confirmation":""}}}, as: :json_api

    #assert_response :created
    #user_response=JSON.parse(response.parsed_body, symbolize_names: true)
    #assert_equal(@user.name, user_response[:data][:attributes][:name])
  end
end
