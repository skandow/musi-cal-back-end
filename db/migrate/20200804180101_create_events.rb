class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.integer :ensemble_id
      t.string :start_time
      t.string :end_time
      t.string :place
      t.string :description
      t.boolean :mandatory

      t.timestamps
    end
  end
end
