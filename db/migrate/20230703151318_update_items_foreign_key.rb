class UpdateItemsForeignKey < ActiveRecord::Migration[6.1]
  def change
    remove_reference :items, :approved_by
  end
end
