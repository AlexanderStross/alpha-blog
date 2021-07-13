require 'test_helper'

class UserSighUpTest < ActionDispatch::IntegrationTest
  test 'get new user form and create user and login' do
    get '/signup'
    assert_response :success
    assert_difference 'User.count', 1 do
      post users_path,
           params: { user: { username: 'successtestuser', email: 'testemail@test.com', password: 'password' } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match 'successtestuser', response.body
  end

  test 'Should fail to create user' do
    get '/signup'
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path,
           params: { user: { username: '', email: '', password: '' } }
    end
    assert_match 'errors', response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end
end
