class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :activity
      t.text :memos

      t.timestamps
    end
  end
end
