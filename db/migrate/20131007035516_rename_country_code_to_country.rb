class RenameCountryCodeToCountry < ActiveRecord::Migration
  def self.up
    rename_column :plaintiffs, :country_code, :country
  end

  def self.down
    rename_column :plaintiffs, :country, :country_code
  end
end
