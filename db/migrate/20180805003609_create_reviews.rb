class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.references :book, foreign_key: true
      t.references :user, foreign_key: true
      # active record enumsを適用するフィールド（セル）にはデフォルト値の設定が必要。
      t.integer :status, default:0, null: false
      t.text :body
      t.timestamps
    end
  end
end
