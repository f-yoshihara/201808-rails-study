# ルーティングとはそもそも指定されたurl（httpメソッド）によってフレームワークの動きを決めるためのもの。
# 言い換えればブラウザとアプリとの窓口はurlであり、その動きを振り分けるのがルーティング。
# urlに意味を持たせるのが ルーティングなのでこれは通常省略できない。indexとか以外は。
# ルートには３つの定義が必要。
# ①httpメソッド ②urlパターン ③コントローラのアクション。②③が同じなら③は省略可能。
# そもそも③がない場合はviewに通す。
# このような仕組みをRESTfulなインターフェイスと呼ぶ？
Rails.application.routes.draw do
  resources :members
  get 'view/keyword'
  resources :fan_comments
  resources :reviews
  resources :authors
  resources :users
  # ↓scaffold実行時に自動で生成される。
  resources :books
  # ↑これがあることでbooksモデルの持つパラメータに複数のルーティングからアクセスできるようになる。
  # つまり複数の便利なルーティングが通される。
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

  # 第5章
  # 2018/08/07
  get 'record/find'
  get 'record/where'
  get 'record/keyword' #アクションメソッドが不要な場合はコントローラの省略できる。直接指定のviewをみに行く。
  # ↓メソッドも合わせないといけない。
  post 'record/ph1' #これはform_tagで生成されるurlのルーティング。必ず必要になるため忘れないようにする必要がある。
  get 'record/select'
  get 'record/offset'
  # ↓これでrecordコントローラのpageメソッドでparams[:id]が利用できる。
  # ()は省略可能という意味。 =>はto:ではダメらしい。
  get 'record/page(/:id)' => 'record#page'
  # 2018/08/08
  get 'record/transact'
  get 'record/keywd'
  post 'record/keywd_process'
  get 'record/belongs'
  get 'record/hasmany'
  get 'record/has_and_belongs'
  get 'record/has_many_through'
end