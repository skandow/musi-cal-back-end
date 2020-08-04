class CreateEnsembles < ActiveRecord::Migration[6.0]
  def change
    create_table :ensembles do |t|
      t.string :name
      t.string :website
      t.string :phone_number
      t.string :email_contact
      t.string :description
      t.string :image_url

      t.timestamps
    end
  end
end
