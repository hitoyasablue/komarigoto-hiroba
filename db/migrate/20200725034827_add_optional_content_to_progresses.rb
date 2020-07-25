class AddOptionalContentToProgresses < ActiveRecord::Migration[6.0]
  def change
    add_column :progresses, :optional_content, :text
  end
end
