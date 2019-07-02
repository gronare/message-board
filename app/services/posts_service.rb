module PostsService
  class << self

    def create_post(context, params)
      Posts::CreatePost.call(context[:current_user], params)
    end

    def update_post(context, params)
      Posts::UpdatePost.call(context[:post_id], context[:current_user], params)
    end

    def destroy_post(context)
      Posts::DestroyPost.call(context[:post_id], context[:current_user])
    end

  end
end
