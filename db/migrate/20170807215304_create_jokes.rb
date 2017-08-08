class CreateJokes < ActiveRecord::Migration
  def change
    create_table :jokes do |t|
      t.integer :number
      t.string :joke
      t.text :categories
    end
  end
end
