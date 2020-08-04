class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_digest
      t.string :email
      t.string :phone_number
      t.string :primary_instrument_or_voice_part
      t.string :secondary_instrument
      t.string :image_url

      t.timestamps
    end
  end
end
