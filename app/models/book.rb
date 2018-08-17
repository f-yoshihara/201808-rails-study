class Book < ApplicationRecord
  validates :isbn,
    presence: true,
    uniqueness: true,
    length: { is: 17 },
    # railsでは正規表現として^と$を使用できない。\Aと\Zを代用する。
    format: { with: /\A[0-9]{3}-[0-9]{1}-[0-9]{3,5}-[0-9]{4}-[0-9X]{1}\z/ }
  validates :title,
    presence: true,
    length: { minimum: 1, maximum: 100 }
  validates :price,
    numericality: { only_integer: true, less_than: 10000 }
  validates :publish,
    inclusion:{ in: ['技術評論社', '翔泳社', '秀和システム', '日経BP社', 'ソシム'] }
  # has_manyでモデルを指定するときはモデル名を複数形にする。
  # 当然bookモデルからreviewモデルを呼び出すときもメソッドは複数形にする。
  has_many :reviews
  # ↑でreviewとの関係を定義した上で↓のようにreviewsを中間テーブルに見立てたusersとの多対多の関係を定義する。
  has_many :users, through: :reviews
  # モデル上での多対多の関係を実現する
  has_and_belongs_to_many :authors
  # 子モデルから見た参照元をmemoableとして定義。
  has_many :memos, as: :memoable

  # after_destroyメソッドで:history_book をコールバックメソッドとして定義している。
  after_destroy :history_book

  private
  # ここから下はprivateメソッド
  # つまり、外部からは参照できない。after_destroyの引数として呼び出されるのみ。
    def history_book
      # これでコンソールに削除したデータの情報をだす。
      logger.info('deleted: ' + self.inspect)
    end

end