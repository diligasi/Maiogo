class AddPictureToUsers < ActiveRecord::Migration
  def change
    add_column :users, :picture, :string
    add_column :users, :profile_link, :string
  end
end
