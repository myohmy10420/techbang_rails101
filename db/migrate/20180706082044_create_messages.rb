class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :content
      t.integer :post_id
      t.integer :user_id

      t.timestamps null: false
    end

    add_index :messages, :post_id
    add_index :messages, :user_id
  end
end
