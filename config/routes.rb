# ルーティングとはそもそも指定されたurl（httpメソッド）によってフレームワークの動きを決めるためのもの。
# 言い換えればブラウザとアプリとの窓口はurlであり、その動きを振り分けるのがルーティング。
# このような仕組みをRESTfulなインターフェイスと呼ぶ？
Rails.application.routes.draw do
  get 'view/keyword'
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

  # 第4章
  get 'view/keyword' # viewコントローラーのkeywordメソッドへのルート。ルートは基本手打ち。
  post 'keyword/search' # formから受け取ったアクションがこのルートを通過する。
  get 'view/form_for'
  get 'view/field'
  get 'view/col_select' 
  get 'view/simple_format'
  get 'view/truncate'
  get 'view/link'
  get 'view/nest'
  get 'view/partial_basic'
  get 'view/partial_col'
  get 'view/partial_param'
end
