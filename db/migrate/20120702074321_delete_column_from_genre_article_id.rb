class DeleteColumnFromGenreArticleId < ActiveRecord::Migration
  def up
    remove_column :genres, :article_id
  end

  def down
    add_column :genres, :article_id, :integer
  end
end
