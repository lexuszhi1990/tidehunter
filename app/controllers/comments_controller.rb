class CommentsController < ApplicationController
  def create
    #binding.pry
    @post = Post.find(params[:post_id])
    @comment = Comment.new(params[:comment])
    @comment.post_id = @post.id
    @comment.user_id = 1

    if @comment.save
      redirect_to post_path(@post)
    else
      render "posts/show"
    end
  end
end
