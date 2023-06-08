class Public::PostsController < ApplicationController
  def new
    @post = Post.new  
  end
  
  # def create
  #   @post_image = PostImage.new(post_image_params)
  #   @post_image.user_id = current_user.id
  #   @post_image.save
  #   redirect_to post_images_path
  # end
  
  
  def create
    @post = Post.new(post_params)

    @post.save!
    redirect_to 'post_path'
  end
  
  def show
  end
  
  private
def post_params
   params.require(:post).permit(:caption, :cosmetic_id, :customer_id)
end
end
