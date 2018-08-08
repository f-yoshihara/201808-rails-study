class Review < ApplicationRecord
  # ↓active record enumsの対応関係をここモデルで定義する.
  # こうすることでテーブルにstringだけ表示してそれに意味を持たせることができる。
  # またオブジェクト.statusの戻り値がkeyになる。
  enum status: {draft:0, published:1, deleted:2}
  belongs_to :book
  belongs_to :user
end
