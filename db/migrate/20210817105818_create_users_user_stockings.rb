class CreateUsersUserStockings < ActiveRecord::Migration[6.1]
  def change
    create_table :user_stockings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :stock, null: false, foreign_key: true

      t.timestamps
    end
  end
end
