class CreatePlaintiffs < ActiveRecord::Migration
  def change
    create_table :plaintiffs do |t|
      t.string :fullname
      t.string :street_address1
      t.string :street_address1_encrypted
      t.string :street_address2
      t.string :street_address2_encrypted
      t.string :postal_code
      t.string :postal_code_encrypted
      t.string :email
      t.string :email_encrypted
      t.string :phone
      t.string :phone_encrypted
      t.boolean :is_public

      t.timestamps
    end
  end
end
