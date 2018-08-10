class Review < ApplicationRecord
  # ↓active record enumsの対応関係をここモデルで定義する.
  # こうすることでテーブルにstringだけ表示してそれに意味を持たせることができる。
  # またオブジェクト.statusの戻り値がkeyになる。
  enum status: {draft:0, published:1, deleted:2}
  # belongs_toはこのモデルからbookモデルを参照したい、という宣言をするメソッド。
  # ここではreviewモデルからBookモデルやUserモデルを参照できるという意味。
  # これが無いと当然@review.book.titleなどでbookがundefined methodになる。
  belongs_to :book
  belongs_to :user
end
