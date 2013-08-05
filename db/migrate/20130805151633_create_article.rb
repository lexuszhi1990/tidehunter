class CreateArticle < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :name
      t.text :body
      t.text :content_html

      t.timestamps
    end
  end
end
