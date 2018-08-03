class CreateLocalizations < ActiveRecord::Migration[5.2]
  def change
    create_table :localizations do |t|
      t.float :latitude
      t.float :longitude
      t.references :survivor, foreign_key: true

      t.timestamps
    end
  end
end
