class Admin::PostsController < ApplicationController
     before_action :authenticate_admin!
    
    def index
    	@posts = Post.all
		

	end

	def show
		@post = Post.find(params[:id])
# 		@order_details = @order.order_details
	end

	def update
		@post = Order.find(params[:id])
        @post.update(post_params)
        flash[:notice] = "注文ステータスの変更しました"
        redirect_to admin_post_path(@post)
        end


#   private
# 	def post_params
# 		params.require(:order).permit(:post_status)
# 	end
end

