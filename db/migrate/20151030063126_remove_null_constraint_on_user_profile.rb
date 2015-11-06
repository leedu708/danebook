class RemoveNullConstraintOnUserProfile < ActiveRecord::Migration
  def change
    change_column :profiles, :user_id, :integer, :null => true
  end
end
