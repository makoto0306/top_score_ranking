class CreateScores < ActiveRecord::Migration[6.1]
  def change
    create_table :scores do |t|
      t.references :player
      t.integer :score, null: false
      t.datetime :time, null: false

      t.timestamps
    end
  end
end
