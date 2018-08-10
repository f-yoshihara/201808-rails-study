class Author < ApplicationRecord
  belongs_to :user
  # モデル上での多対多の関係を実現する。
  has_and_belongs_to_many :books
  # 子モデルから見た参照元をmemoableとして定義。
  has_many :memos, as: :memoable
end
