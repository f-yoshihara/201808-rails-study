# 非DB系モデル
class SearchKeyword
  include ActiveModel::Model

  attr_accessor :keyword
  # 検証をかける。presenceで値が空かどうかチェック。
  validates :keyword, presence: true
end
