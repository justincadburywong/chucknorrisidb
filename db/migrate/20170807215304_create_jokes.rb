class CreateJokes < ActiveRecord::Migration
  def change
    create_table :jokes do |t|
      t.integer :id
      t.string :joke
      t.text :categories
    end
  end
end
