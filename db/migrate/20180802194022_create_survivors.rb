class CreateSurvivors < ActiveRecord::Migration[5.2]
  def change
    create_table :survivors do |t|
      t.string :name
      t.string :gender
      t.integer :age
      t.boolean :abducted

      t.timestamps
    end
  end
end
