class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.boolean :state

      t.timestamps
    end
  end
end
