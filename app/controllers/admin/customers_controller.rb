class Admin::CustomersController < ApplicationController
    before_action :authenticate_admin!
    
  def index
    @customers = Customer.all
    # @search = Customer.ransack(params[:q])
    # @customers = @search.result.page(params[:page]).per(10)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:success] = "Customer was successfully updated"
      redirect_to admin_customer_path(@customer)
    else
      render "edit"
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :is_customer_status, :is_deleted)
  end
end
