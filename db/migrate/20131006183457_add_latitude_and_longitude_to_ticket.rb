class AddLatitudeAndLongitudeToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :latitude, :float
    add_column :tickets, :longitude, :float
  end
end
