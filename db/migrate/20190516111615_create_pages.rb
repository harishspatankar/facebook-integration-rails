class CreatePages < ActiveRecord::Migration[5.2]
  def change
    create_table :pages do |t|
      t.text :page_id
      t.text :name
      t.text :category
      t.references :user

      t.timestamps
    end
  end
end
