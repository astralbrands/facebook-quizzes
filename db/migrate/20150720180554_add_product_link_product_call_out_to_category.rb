class AddProductLinkProductCallOutToCategory < ActiveRecord::Migration
  def change
  	change_table :categories do |t|
  		t.string :product_link
  		t.string :product_call_out
  	end
  end
end
