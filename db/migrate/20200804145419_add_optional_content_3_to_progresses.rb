class AddOptionalContent3ToProgresses < ActiveRecord::Migration[6.0]
  def change
    add_column :progresses, :optional_content_3, :text
  end
end
