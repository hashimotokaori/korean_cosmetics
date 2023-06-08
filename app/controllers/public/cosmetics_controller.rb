class Public::CosmeticsController < ApplicationController
  
  def search
    if params[:keyword]
      @cosmetics = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])
    end
    
  end
  def index
    @cosmetics_all = Cosmetic.all

  end

  def show
    @cosmetic = Cosmetic.find_by(params[:id])
  end
end
