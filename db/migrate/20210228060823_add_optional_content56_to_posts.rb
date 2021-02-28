class AddOptionalContent56ToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :optional_content_5, :text
    add_column :posts, :optional_content_6, :text
  end
end
