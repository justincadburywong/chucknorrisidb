class CreateJokes < ActiveRecord::Migration
  def change
    create_table :jokes do |t|
      t.string :joke
      t.text :categories
    end
  end
end
