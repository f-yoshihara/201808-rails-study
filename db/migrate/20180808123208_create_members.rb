class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.string :name
      t.string :email
      # default: 0の部分を追記
      t.integer :lock_version, default: 0

      t.timestamps
    end
  end
end
