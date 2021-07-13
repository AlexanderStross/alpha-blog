require 'test_helper'

class NewArticleTest < ActionDispatch::IntegrationTest
  setup do
    @category = Category.create(name: 'Sports')
    @user = User.create(username: 'johny', email: 'johnys@test.com', password: 'password', admin: false)
    sign_in_as(@user)
  end

  test 'get new article form and create article without categories' do
    get '/articles/new'
    assert_response :success
    assert_difference 'Article.count', 1 do
      post articles_path,
           params: { article: { title: 'Testarticlewithoutcategories', description: 'Testarticlewithoutcategories',
                                categories: '' } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match 'Testarticlewithoutcategories', response.body
  end

  test 'get new article form and create article with categories' do
    get '/articles/new'
    assert_response :success
    assert_difference 'Article.count', 1 do
      post articles_path,
           params: { article: { title: 'Testarticlewithoutcategories', description: 'Testarticlewithoutcategories',
                                categories: 'Sports' } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match 'Testarticlewithoutcategories', response.body
  end

  test 'Should fail to create Article' do
    get '/articles/new'
    assert_response :success
    assert_no_difference 'Article.count' do
      post articles_path,
           params: { article: { title: '', description: '', categories: '', user_id: '' } }
    end
    assert_match 'errors', response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end
end
