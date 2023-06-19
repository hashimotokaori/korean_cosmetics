class Public::PostsController < ApplicationController
  
  def new
    return redirect_to root_path unless params[:cosmetic_id]
    @post = Post.new  
    @cosmetic = Cosmetic.find(params[:cosmetic_id])
    @cosmetic_id = params[:cosmetic_id]
  end
  
  # def create
  #   @post_image = PostImage.new(post_image_params)
  #   @post_image.user_id = current_user.id
  #   @post_image.save
  #   redirect_to post_images_path
  # end
  
  
  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    @post.save!
    redirect_to posts_path
  end
  
  def index
    @posts = Post.all.page(params[:page])
    @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.all
    # @cosmetic = Cosmetic.find(params[:cosmetic_id])
  end
  
  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @cosmetic = Cosmetic.find(params[:id])
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end
  
  def update_review
    @post = Post.find(params[:id])
    @cosmetic = Cosmetic.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    # @cosmetic = Cosmetic.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      redirect_to post_update_review_path(@post) 
    end
  end
  
  
  private
  def post_params
    params.require(:post).permit(:caption, :cosmetic_id, :customer_id, :review, :star, :image, tag_ids: [])
  end
end
