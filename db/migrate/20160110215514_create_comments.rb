class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :text, null: false, limit: 1000
      t.references :task, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
