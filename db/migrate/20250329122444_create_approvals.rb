class CreateApprovals < ActiveRecord::Migration[7.2]
  def change
    create_table :approvals do |t|
      t.date :request_date
      t.date :acquisition_date, null: false
      t.boolean :paid_applicable, null: false, default: false
      t.boolean :paid_confirm, null: false, default: false
      t.references :paid_leave, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :paid_remarks

      t.timestamps
    end
  end
end
