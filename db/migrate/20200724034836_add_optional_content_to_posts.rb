class AddOptionalContentToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :optional_content, :text
  end
end
