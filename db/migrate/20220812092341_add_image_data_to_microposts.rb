class AddImageDataToMicroposts < ActiveRecord::Migration[6.1]
  def change
    add_column :microposts, :image_data, :text
  end
end
