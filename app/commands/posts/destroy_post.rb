class Posts::DestroyPost
  prepend SimpleCommand

  def initialize(post_id, current_user)
    @post_id = post_id
    @user = current_user
  end

  def call
    post = @user.posts.find_by_id(@post_id)
    return errors.add(:unauthorized, 'ownership missing') && nil unless post
    errors.add_multiple_errors(post.errors.messages) unless post.destroy
    post
  end
end
