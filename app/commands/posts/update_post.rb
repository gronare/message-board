class Posts::UpdatePost
  prepend SimpleCommand

  def initialize(post_id, current_user, params)
    @user = current_user
    @post_id = post_id
    @params = params
  end

  def call
    post = @user.posts.find_by_id(@post_id)
    return errors.add(:unauthorized, 'ownership missing') && nil unless post
    errors.add_multiple_errors(post.errors.messages) unless post.update(@params)
    post
  end
end
