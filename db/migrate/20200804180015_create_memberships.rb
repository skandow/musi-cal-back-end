class CreateMemberships < ActiveRecord::Migration[6.0]
  def change
    create_table :memberships do |t|
      t.integer :user_id
      t.integer :ensemble_id
      t.boolean :admin
      t.string :performing_roles
      t.string :administrative_roles

      t.timestamps
    end
  end
end
