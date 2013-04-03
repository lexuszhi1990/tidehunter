class CreateTravels < ActiveRecord::Migration
  def change
    create_table :travels do |t|
      t.string :place
      t.date :when
      t.text :body

      t.timestamps
    end
  end
end
