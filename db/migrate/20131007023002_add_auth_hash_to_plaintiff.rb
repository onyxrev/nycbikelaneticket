class AddAuthHashToPlaintiff < ActiveRecord::Migration
  def change
    add_column :plaintiffs, :auth_hash, :string
  end
end
