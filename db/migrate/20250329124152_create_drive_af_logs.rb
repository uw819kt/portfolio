class CreateDriveAfLogs < ActiveRecord::Migration[7.2]
  def change
    create_table :drive_af_logs do |t|
      t.datetime :check_time, null: false
      t.integer :confirmation, null: false
      t.boolean :detector_used, null: false, default: true
      t.float :result, null: false
      t.integer :condition, null: false, default: 0
      t.text :log_remarks
      t.references :car, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
