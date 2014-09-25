class CreateLabels < ActiveRecord::Migration
  def change
    create_table :labels do |t|
      t.integer :article_id
      t.integer :quantity
      t.integer :group_label_id
      t.timestamps
    end
  end
end
