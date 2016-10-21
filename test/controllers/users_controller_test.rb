require 'test_helper'

class ApiTest < ActionDispatch::IntegrationTest
  test 'creates user' do
    assert_difference -> { User.count } do
      post api_v1_users_path, params: {"data":{"type":"users","attributes":{"name":"test1","email":"test1@example.com","password":"123456","password_confirmation":"123456"}}}, as: :json_api
    end

    assert_response :created
    assert_equal({ id: User.last.id, name: 'test1' }, response.parsed_body)
  end
end