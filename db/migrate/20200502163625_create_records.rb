class CreateRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :records do |t|
      t.references :artist, null: false, foreign_key: true
      t.string :title, null: false
      t.references :user, null: false, foreign_key: true
      t.integer :year, null: false
    end
  end
end
