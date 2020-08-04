class AddContent2ToProgresses < ActiveRecord::Migration[6.0]
  def change
    add_column :progresses, :content_2, :text
  end
end
