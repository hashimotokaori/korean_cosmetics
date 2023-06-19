class Public::CustomersController < ApplicationController
   
  def show
   @posts = Post.where(customer_id: current_customer.id)
   @want_posts = @posts.where.not(caption: nil).where(review: nil, star: nil)
   @used_posts = @posts.where.not(review: nil, star: nil)
   @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.all     
#   cosmetics = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])
#     results = cosmetics.map { |cosmetic| Cosmetic.new(read(cosmetic))}
#     cosmetic_item_codes = Cosmetic.pluck(:item_code)
#     @cosmetics = results.map do |result|    
#       unless result.item_code.in?(cosmetic_item_codes)
#       result.save! 
#       result
#       else
#         Cosmetic.find_by(item_code: result.item_code)
#       end
#     end
  end
  
  def edit
   @customer = current_customer
  end
  
  private
        def customer_params
            params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :is_customer_status, tag_ids: [])
        end
    #     def read(result)
    # name = result["itemName"]
    # url = result["itemUrl"]
    # item_code = result["itemCode"]
    # image_url = result["mediumImageUrls"]&.first
    # price = result["itemPrice"]
    # caption = result["itemCaption"]
    
    # {
    #   name: name,
    #   url: url,
    #   item_code: item_code,
    #   image_url: image_url,
    #   price: price,
    #   caption: caption
    # }
    #     end 
end
