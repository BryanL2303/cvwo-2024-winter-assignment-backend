class UpdateLabelsAndPosts < ActiveRecord::Migration[7.0]
  def change
    change_table :posts do |t|
      t.remove :label_id
    end

    create_table :post_labels do |t|
      t.belongs_to :post
      t.belongs_to :label
      
      t.timestamps
    end
  end
end
