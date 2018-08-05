# ルーティングとはそもそも指定されたurl（httpメソッド）によってフレームワークの動きを決めるためのもの。
# 言い換えればブラウザとアプリとの窓口はurlであり、その動きを振り分けるのがルーティング。
# このような仕組みをRESTfulなインターフェイスと呼ぶ？
Rails.application.routes.draw do
  resources :fan_comments
  resources :reviews
  resources :authors
  resources :users
  # ↓scaffold実行時に自動で生成される。
  resources :books
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # 'hello/index'というurlをgetしたらhelloコントローラーのindexメソッドを実行する。という意味。
  get 'hello/index', to: 'hello#index'
  # getとtoが一致している時はto:以下を省略可能。
  # get 'hello/index'
  get 'hello/view', to: 'hello#view'
  get 'hello/list', to: 'hello#list'
end
