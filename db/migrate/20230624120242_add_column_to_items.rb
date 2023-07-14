# frozen_string_literal: true

# This is a class
class AddColumnToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :approved, :boolean, default: false
    add_reference :items, :user, foreign_key: true
    add_reference :items, :approved_by, foreign_key: { to_table: :users }
    add_column :items, :category_id, :integer
  end
end
