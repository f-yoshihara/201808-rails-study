# rails g controller hello で生成したファイルのひとつ。
# ApplicationControllerというクラスを継承している。
class HelloController < ApplicationController
  def index
    # render plane: で引数の文字列をブラウザで表示する。
    render plain: 'こんにちは'
  end
  def view
    @msg = 'test'
    # render の引数は表示したいファイルをapp/viewsフォルダからの相対パスで記述する。
    # ファイル名の拡張子は省略。
    render 'hello/view'
  end
  def list
    @books = Book.all
  end
end
