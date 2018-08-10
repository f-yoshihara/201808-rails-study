class Memo < ApplicationRecord
  # 親モデルが複数あるがまとめて:memoableとしている
  # polymorphic: trueにすることで子モデル側でポリモーフィック関連の関係を明示的に宣言している。
  belongs_to :memoable, polymorphic: true
end
