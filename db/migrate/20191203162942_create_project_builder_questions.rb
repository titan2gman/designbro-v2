class CreateProjectBuilderQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :project_builder_questions do |t|
      t.integer :position

      t.string :attribute_name
      t.string :component_name

      t.json :props

      t.json :validations

      t.references :project_builder_step

      t.timestamps
    end
  end
end
