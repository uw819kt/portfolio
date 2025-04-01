class CreateCars < ActiveRecord::Migration[7.2]
  def change
    create_table :cars do |t|
      t.string :company_car
      t.string :private_car
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
