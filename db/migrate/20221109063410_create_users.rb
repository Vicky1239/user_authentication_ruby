class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, unique: true
      t.string :password_digest, require: true
      t.string :first_name, require: true
      t.string :last_name, require: true
      t.string :mobile_number, require: true
      t.string :country_code, require: true

      t.timestamps
    end
  end
end
