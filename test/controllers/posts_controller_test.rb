require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @carls_post = posts(:hello_world)
    @calles_post = posts(:small_world)
    @carls_token = auth_token(users(:carl))
    @calles_token = auth_token(users(:calle))
  end

  test "should return all post without being logged in" do
    get posts_path
    assert_response :success
    assert_equal JSON.parse(response.body).count, 2
  end

  test "should return unauthorized on create when jwt token missing" do
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { body: "Hello again" } }
    end
    assert_response :unauthorized
    assert_equal response.body, "{\"error\":\"Not Authorized\"}"
  end

  test "should return unauthorized on update when jwt token missing" do
    put post_path(@carls_post), params: { post: { body: "Hello again to you" } }
    assert_response :unauthorized
    assert_equal response.body, "{\"error\":\"Not Authorized\"}"
  end

  test "should return unauthorized on destroy when jwt token missing" do
    assert_no_difference 'Post.count' do
      delete post_path(@carls_post)
    end
    assert_response :unauthorized
    assert_equal response.body, "{\"error\":\"Not Authorized\"}"
  end

  test "should return new post on create when user authenticated" do
    assert_difference 'Post.count' do
      post posts_path, params: { post: { body: "Aello Hgain" } }, headers: { 'Authorization': @carls_token }
    end
    assert_response :created
    assert_includes response.body, "\"body\":\"Aello Hgain\",\"user_id\":#{users(:carl).id}"
  end

  test "should not update post not belonging to authenticated user" do
    put post_path(@carls_post),
      params: { post: { body: "Hello again to you" } },
      headers: { 'Authorization': @calles_token }
    assert_response :unauthorized
    assert_includes response.body, "ownership missing"
  end

  test "should update post belonging to authenticated user" do
    put post_path(@carls_post),
      params: { post: { body: "Summer is comming" } },
      headers: { 'Authorization': @carls_token }
    assert_response :success
    assert_includes response.body, "Summer is comming"
  end

  test "should not destroy other users post" do
    assert_no_difference 'Post.count' do
      delete post_path(@carls_post),
        headers: { 'Authorization': @calles_token }
    end
    assert_response :unauthorized
    assert_includes response.body, "ownership missing"
  end

  test "should destroy authenticated users post" do
    assert_difference 'Post.count', -1 do
      delete post_path(@calles_post),
        headers: { 'Authorization': @calles_token }
    end
    assert_response :success
  end

end
