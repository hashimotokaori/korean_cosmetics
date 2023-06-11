class Public::CosmeticsController < ApplicationController
  
  def new
    @cosmetic = Cosmetic.new  
  end
  
  def search
    if params[:keyword]
      @cosmetics = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])
      if @keyword.present?
      results = RakutenWebService::Ichiba::Item.search({
      keyword: @keyword,
      })
      results.each do |result|
        cosmetic = Cosmetic.new(read(result))
        @cosmetics << cosmetic
      end
      end
    end
    @cosmetics.each do |cosmetic|
      unless Cosmetic.all.include?(cosmetic)
        cosmetic.save
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
    name = result["name"]
    introduction = result["introduction"]
    url = result["itemUrl"]
    isbn = result["isbn"]
    image_url = result["mediumImageUrl"].gsub('?_ex=120x120', '')
    price = result["price"]
    caption = result["caption"]
    {
      name: name,
      introduction: introduction,
      url: url,
      isbn: isbn,
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
