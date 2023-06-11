class Public::CosmeticsController < ApplicationController
  
  def new
    @cosmetic = Cosmetic.new  
  end
  
  def search
    if params[:keyword]
      @cosmetics = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])
    end
  end    
  
  def create
    @cosmetic = Cosmetic.new(cosmetic_params)
    @cosmetic.customer_id = current_customer.id
    @post.save!
    redirect_to cosmetics_path
  end  
    
  
  def index
    @cosmetics_all = Cosmetic.all

  end

  def show
    @cosmetic = Cosmetic.find(params[:id])
    @posts = @cosmetic.posts
    @post = @posts.first
  end
end
