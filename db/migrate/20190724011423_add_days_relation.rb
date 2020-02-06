class AddDaysRelation < ActiveRecord::Migration[5.2]
  def up
    create_table :movie_days do |t|
      t.belongs_to :day, index: true
      t.belongs_to :movie, index: true
    end
  end

  def down
    drop_table :movie_days
  end
end
