class AddColumnArticleIdToArticle < ActiveRecord::Migration
  def up
    add_column :articles, :genre_id, :integer
  end
  
  def down
    remove_column :articles, :genre_id
  end
end
