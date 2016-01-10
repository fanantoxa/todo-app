class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name, null: false, limit: 250
      t.boolean :status, null: false, default: false
      t.integer :position, null:false
      t.datetime :due_date
      t.references :project, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
