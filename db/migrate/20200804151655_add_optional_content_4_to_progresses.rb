class AddOptionalContent4ToProgresses < ActiveRecord::Migration[6.0]
  def change
    add_column :progresses, :optional_content_4, :text
  end
end
