class RecordController < ApplicationController
  # before_action :set_book, only: [:show, :edit, :update, :destroy]
  def find
    # @でテンプレート変数を宣言。これはrubyのインスタンス変数と同じ。
    # Bookはmodels/book.rbで定義されたクラス。
    # BookはApplicationRecordを継承しているのでfindメソッドを持っている。
    # findは引数にデータの主キーをとる。
    # ここでは配列として複数の主キーをfindしている
    # そしてテンプレート変数@bookにオブジェクトの配列を代入している。
    @book = Book.find([2, 5, 11])
    # renderは引数にviews以下からテンプレートまでのパスをとることでテンプレートを呼び出す。
    # 呼び出した先で@で宣言したテンプレート変数を参照できる。
    # ここでのrenderはアクションメソッドのひとつ。
    render 'hello/list'
  end
  def where
    # これがメソッドチェーン。
    # whereとorderを繋げて一つのクエリにしている。
    # それぞれのメソッドの引数として条件はハッシュで表現している。
    # Bookクラスがbooksテーブル全体を意味する。
    @books = Book.where(publish: '技術評論社').order(published: :desc)
    # SELECT "books".* FROM "books" WHERE "books"."publish" = ? ORDER BY "books"."published" DESC 
    # ↑が生成されたクエリ。
    render 'hello/list'
  end
  def ph1
    # 第一引数で条件指定。
    # 第二引数以降でレコードのインスタンスを持ってきている。
    # 「?」の部分がプレイスホルダー
    # 「?」の順番と引数の順番は合わせる。順番に代入されていく。
    # 
    # @books = Book.where('publish = ? AND price >= ?',
      # ↑名前なしパラメータ ↓名前つきパラメータ
    @books = Book.where('publish = :publish AND price >= :price',
      # paramsはメソッドでここからhttpを通して受けたクライアントからのリクエスト情報を取得することができる。
      # リクエスト情報とはpostされた値やurl末尾の情報など
      # 今回はpostで受けているのでpostの値。
      # params[:publish], params[:price])
        # ↑名前なしパラメータ ↓名前つきパラメータ
      publish: params[:publish], price: params[:price])
    render 'hello/list'
  end

  def select
    # SELECT "books"."title", "books"."price" FROM "books" WHERE (price >= 2000)
    # ↑が生成される。@bookはtitleとprice以外のプロパティを持たない。
    # ちなみに"books"."title"の部分がbooksテーブルのpriceカラムという意味。
    # "books".*は全部のカラムという意味。
    @books = Book.where('price >= 2000').select(:title, :price)
    render 'hello/list'
  end

  def offset
    # offset(4)で4番目までを相殺し、limit(3)で3番目までを取り出す。
    @books = Book.order(published: :desc).limit(3).offset(4)
    render 'hello/list'
  end

  def page
    page_size = 3 #ページあたりの表示件数
    # ↓条件演算子でparams[:id]がnilの場合はpage_numに0を代入
    # それ以外はparams[:id].to_i - 1
    page_num = params[:id] == nil ? 0 : params[:id].to_i - 1 #
    # ↑ルート get 'record/page(/:id)' => 'record#page' から
    # ↓offsetは相殺。limitは表示件数。
    @books = Book.order(published: :desc).limit(page_size).offset(page_size * page_num)
    render 'hello/list'
  end

  def transact
      # transactionメソッドはモデルクラスが持っている。インスタンスからでも呼び出せる。
      Book.transaction do
        b1 = Book.new({isbn: '0000',
          title: 'Ruby',
          price: 3000,
          publish: '技術評論社',
          published: '2018-08-08'})
        # この時点ではsave!は実行されない。
        # saveは戻り値としてtrue/falseを返すが、save!はエラーの時に例外を返す。
        # rubyではほぼ全てのメソッドが戻り値を返す。全ての式が値を値をもつという基本思想があるため。
        b1.save!
        # raiseは意図的に例外を発生させるためのメソッド。
        # 引数の文字列がエラーメッセージとして登録される。
        # 後から出てくるmessageメソッドで取り出される。
        raise '例外発生：処理はキャンセルされました。'
        b2 = Book.new({isbn: '0000',
          title: 'rails',
          price: 5000,
          publish: '技術評論社',
          published: '2018-08-10'})
        b2.save!
      end
      # ここまでがトランザクションブロック。
      render plain: 'トランザクション成功'
    # 例外が発生した時はrescueを定義しておくことで処理を続行することができる。これが例外処理。
    # 例外が発生した時には処理がrescueまでジャンプしてそれ以降が実行される。
    # 例外自体もオブジェクトとして扱われている。そこから情報を引き出すことができる。それを変数eに格納している。
    # この=>はrescueから例外を格納するための特別な書き方。
    rescue => e
      # messageメソッドは例外オブジェクトが持っているメソッドで、エラーメッセージを返す。
      # この場合はraiseメソッドで'例外発生：処理はキャンセルされました。'が格納されている。
      # render plain: e.message
      render plain: e.backtrace
  end

  def keywd
    # これは非DB系モデル
    @search = SearchKeyword.new
  end

  def keywd_process
    # validがかかったかどうかの結果も含めて@searchが生成される。
    @search = SearchKeyword.new(params.require(:search_keyword).permit(:keyword))

    # ここで条件分岐
    if @search.valid?
      render plain: @search.keyword
    else
      render plain: @search.errors.full_messages[0]
    end
  end
end
