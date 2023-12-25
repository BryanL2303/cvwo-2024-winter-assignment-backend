class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.belongs_to :user
      t.belongs_to :label
      t.string :title
      t.string :description
      t.string :date
      t.string :author

      t.timestamps
    end
  end
end
