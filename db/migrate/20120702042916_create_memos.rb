class CreateMemos < ActiveRecord::Migration
  def change
    create_table :memos do |t|
      t.text :text
      t.string :url
      t.integer :article_id

      t.timestamps
    end
  end
end
