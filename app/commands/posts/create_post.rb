class Posts::CreatePost
  prepend SimpleCommand

  def initialize(current_user, params)
    @user = current_user
    @params = params
  end

  def call
    post = @user.posts.new(@params)
    errors.add_multiple_errors(post.errors.messages) unless post.save
    post
  end
end
