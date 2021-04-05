class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.string :category
      t.string :name
    end
    add_index :tags, [:category, :name], unique: true
  end
end
