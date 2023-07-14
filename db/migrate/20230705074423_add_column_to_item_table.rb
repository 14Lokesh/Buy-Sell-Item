# frozen_string_literal: true

# This is a class
class AddColumnToItemTable < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :approved_by_id, :integer
    remove_reference :items, :user
    add_column :items, :user_id, :integer
    remove_column :items, :user_id, :integer
    add_reference :items, :user, foreign_key: true
  end
end
