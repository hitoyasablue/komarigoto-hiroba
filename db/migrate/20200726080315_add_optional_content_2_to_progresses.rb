class AddOptionalContent2ToProgresses < ActiveRecord::Migration[6.0]
  def change
    add_column :progresses, :optional_content_2, :text
  end
end
