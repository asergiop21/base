class CreateGroupLabels < ActiveRecord::Migration
  def change
    create_table :group_labels do |t|
      t.string :name

      t.timestamps
    end
  end
end
