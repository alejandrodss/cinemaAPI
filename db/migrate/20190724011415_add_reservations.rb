class AddReservations < ActiveRecord::Migration[5.2]
  def up
    create_table :days do |table|
      table.string :name
      table.string :code, null: false, index: { unique: true }
    end

    create_table :reservations do |table|
      table.belongs_to :movie, index: true, foreign_key: true
      table.belongs_to :day, foreign_key: true
      table.integer :identification_number
      table.string :name
      table.string :email
      table.integer :phone
    end
  end

  def down
    drop_table :reservations
    drop_table :days
  end
end
