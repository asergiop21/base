class AddColumnDtoToOrder < ActiveRecord::Migration
  def self.up
        add_column :orders, :discount, :decimal, :precision => 8 , :scale => 2
  end


  def self.down
        remove_column :orders, :discount
  end



end
