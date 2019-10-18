class CreateParkings < ActiveRecord::Migration[6.0]
  def change
    create_table :parkings do |t|
      t.string :plate
      t.datetime :car_in
      t.datetime :car_out
      t.boolean :paid

      t.timestamps
    end
  end
end
