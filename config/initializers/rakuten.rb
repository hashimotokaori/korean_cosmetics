RakutenWebService.configure do |c|
  # (必須) アプリケーションID
  c.application_id = '1094005251197828124'

  # (任意) 楽天アフィリエイトID
  c.affiliate_id = '32e2fcfb.b1cd53f6.32e2fcfc.8a896e7d'

  # (任意) リクエストのリトライ回数
    # 一定期間の間のリクエスト数が制限を超えた時、APIはリクエスト過多のエラーを返す。
    # その後、クライアントは少し間を空けた後に同じリクエストを再度送る。
    c.max_retries = 3 # default: 5

    # (任意) デバッグモード
    # trueの時、クライアントはすべてのHTTPリクエストとレスポンスを標準エラー出力に流す。
    c.debug = true # default: false
end