class RenameAuthorColumnToPosterInComments < ActiveRecord::Migration
  def change
    rename_column :comments, :author_id, :poster_id
  end
end
