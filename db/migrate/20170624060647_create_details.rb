class CreateDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :details do |t|
      t.string :street
      t.string :city
      t.integer :zip
      t.string :state
      t.integer :beds
      t.integer :baths
      t.integer :sq__ft
      t.string :building_type
      t.timestamp :sale_date
      t.integer :price
      t.decimal :latitude, {:precision=>10, :scale=>6}
      t.decimal :longitude, {:precision=>10, :scale=>6}

      t.timestamps
    end
  end
end
