class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.string :message ,null: false
      t.references :user, null: false, foreign_key: true
      t.boolean :read , default: false

      t.timestamps
    end
  end
end
