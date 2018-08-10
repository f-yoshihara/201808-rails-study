class User < ApplicationRecord
  has_one :auther
  has_many :reviews
  # ↑でreviewとの関係を定義した上で↓のようにreviewsを中間テーブルに見立てたbooksとの多対多の関係を定義する。
  has_many :books, through: :reviews
end
