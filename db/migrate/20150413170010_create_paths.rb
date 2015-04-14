class CreatePaths < ActiveRecord::Migration
  def change
    create_table :paths do |t|
      t.string :local
      t.string :begin_point
      t.string :end_point
      t.integer :distance

      t.timestamps
    end
  end
end
