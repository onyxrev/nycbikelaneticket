class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :number
      t.integer :fine_cents
      t.integer :expenses_cents
      t.string :location
      t.datetime :date
      t.string :officer_id
      t.datetime :hearing_date
      t.integer :hearing_verdict
      t.datetime :appeal_date
      t.integer :appeal_verdict
      t.text :description
      t.integer :plaintiff_id

      t.timestamps
    end
  end
end
