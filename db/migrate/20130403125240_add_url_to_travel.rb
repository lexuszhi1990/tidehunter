class AddUrlToTravel < ActiveRecord::Migration
  def change
    add_column :travels, :image_url, :string
  end
end
