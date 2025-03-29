class CreateGrants < ActiveRecord::Migration[7.2]
  def change
    create_table :grants do |t|
      t.integer :granted_piece, null: false
      t.date :granted_day, null: false
      t.references :paid_leave, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
