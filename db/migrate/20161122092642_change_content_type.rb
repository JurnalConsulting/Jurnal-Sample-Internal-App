class ChangeContentType < ActiveRecord::Migration
  def change
    change_column :table_webhook_records, :content,  :text
  end
end
