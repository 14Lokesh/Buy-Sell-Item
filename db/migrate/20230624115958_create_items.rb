# frozen_string_literal: true

# This is a class
class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :title
      t.string :description
      t.string :username
      t.string :phone
      t.string :city
      t.json :images

      t.timestamps
    end
  end
end
