class CreateDeclensionNames < ActiveRecord::Migration[5.2]
  def change
    create_table :declension_names do |t|
      t.text :genitive, null: false
      t.text :dative, null: false
      t.text :accusative, null: false
      t.text :instrumental, null: false
      t.text :prepositional, null: false
      t.references :person, foreign_key: true, null: false

      t.timestamps
    end
  end
end
