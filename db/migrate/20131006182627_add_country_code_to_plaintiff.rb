class AddCountryCodeToPlaintiff < ActiveRecord::Migration
  def change
    add_column :plaintiffs, :country_code, :string
  end
end
