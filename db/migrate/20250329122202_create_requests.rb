class CreateRequests < ActiveRecord::Migration[7.2]
  def change
    create_table :requests do |t|
      t.date :request_date, null: false
      t.date :acquisition_date, null: false
      t.references :user, null: false, foreign_key: true
      t.references :paid_leave, null: false, foreign_key: true
      t.text :paid_remarks
      
      t.timestamps
    end
  end
end
