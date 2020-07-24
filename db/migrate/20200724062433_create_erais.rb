class CreateErais < ActiveRecord::Migration[6.0]
  def change
    create_table :erais do |t|
      t.integer :user_id, null: false
      t.integer :progress_id, null: false

      t.timestamps

      t.index :user_id
      t.index :progress_id
      t.index [:user_id, :progress_id], unique: true
    end
  end
end
