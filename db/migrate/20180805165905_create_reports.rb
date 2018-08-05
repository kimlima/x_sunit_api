class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.integer :abducted_quantity
      t.integer :survivors_quantity

      t.timestamps
    end
  end
end
