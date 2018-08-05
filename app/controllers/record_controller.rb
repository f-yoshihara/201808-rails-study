def find
  # @でテンプレート変数を宣言。これはrubyのインスタンス変数と同じ。
  # Bookはmodels/book.rbで定義されたクラス。
  # BookはApplicationRecordを継承しているのでfindメソッドを持っている。
  # findは引数にデータの主キーをとる。
  # ここでは配列として複数の主キーをfindしている
  @book = Book.find([2, 5, 10])
  # renderは引数にviews以下からテンプレートまでのパスをとることでテンプレートを呼び出す。
  # 呼び出した先で@で宣言したテンプレート変数を参照できる。
  # ここでのrenderはアクションメソッドのひとつ。
  render 'hello/list'
end
