class CreateWebhookUsers < ActiveRecord::Migration
  def change
    create_table :webhook_users do |t|
      t.string :webhook_user_value
      t.timestamps
    end
  end
end
