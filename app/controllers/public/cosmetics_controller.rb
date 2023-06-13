class Public::CosmeticsController < ApplicationController
  
  def new
    @cosmetic = Cosmetic.new  
  end
  
  def search
    cosmetics = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])
    results = cosmetics.map { |cosmetic| Cosmetic.new(read(cosmetic))}
    cosmetic_item_codes = Cosmetic.pluck(:item_code)
    @cosmetics = results.map do |result|    
      unless result.item_code.in?(cosmetic_item_codes)
       result.save! 
       result
      else
        Cosmetic.find_by(item_code: result.item_code)
      end
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
  
  
  private
  #「楽天APIのデータから必要なデータを絞り込む」、且つ「対応するカラムにデータを格納する」メソッドを設定していきます。
  def read(result)
    name = result["itemName"]
    url = result["itemUrl"]
    item_code = result["itemCode"]
    image_url = result["mediumImageUrls"]&.first
    price = result["itemPrice"]
    caption = result["itemCaption"]
    {
      name: name,
      url: url,
      item_code: item_code,
      image_url: image_url,
      price: price,
      caption: caption
    }
  end
end
  
  
  
  
#   private
#     #楽天市場の店指定のアイテムを取得
#     def create_rakuten_data(params)
#       @results = RakutenWebService::Ichiba::Item.search(
#         shopCode: 'shop-senjin',
#         page: params[:page],
#         hits: 30)
# 　　　 #ここで取得したアイテムをテーブルに保存するがすでに保存されているアイテムは保存しない処理を行う
#       @results.each do |result|
#         #取得したデータの配列のresultを引数にprivetメソッドreadを呼び出し
#         item = Cosmetic.new(read(result))
#         #rakutensテーブルに同じアイテムがあれば保存しない処理
#         unless Cosmetic.all.exists?(item_name: item.item_name)
#           item.save
#         end
#       end
#     end

#     def read(result)
#       #Rakutenモデルのインスタンスに埋め込む
#       image_url = result['mediumImageUrls'][0]
#       item_name = result['itemName']
#       item_price = result['itemPrice']
#       item_url = result['itemUrl']
#       shop_name = result['shopCode']
#       genre_id = result['genreId']
#       review_average = result['reviewAverage']
#       {
#         image_urls: image_url,
#         item_name: item_name,
#         item_price: item_price,
#         item_url: item_url,
#         shop_name: shop_name,
#         genle_id: genre_id,
#         review_average: review_average
#       }
#     end
# end
