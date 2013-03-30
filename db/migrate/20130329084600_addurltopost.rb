class Addurltopost < ActiveRecord::Migration
  def change
    add_column :posts, :tag, :string
  end
end
