class AddOptionalContent234ToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :optional_content_2, :text
    add_column :posts, :optional_content_3, :text
    add_column :posts, :optional_content_4, :text
  end
end
