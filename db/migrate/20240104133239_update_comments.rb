class UpdateComments < ActiveRecord::Migration[7.0]
  def change
    change_table :comments do |t|
      t.string :author
      t.string :date
    end
  end
end
