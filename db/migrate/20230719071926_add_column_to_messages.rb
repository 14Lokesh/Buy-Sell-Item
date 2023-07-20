# frozen_string_literal: true

# This is a class
class AddColumnToMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :read, :boolean, default: false
  end
end
