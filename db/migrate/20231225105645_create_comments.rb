class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.belongs_to :user
      t.belongs_to :post
      t.integer :parent_comment_id
      t.string :comment

      t.timestamps
    end
  end
end
