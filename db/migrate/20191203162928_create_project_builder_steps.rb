class CreateProjectBuilderSteps < ActiveRecord::Migration[5.2]
  def change
    create_table :project_builder_steps do |t|
      t.string :path
      t.string :name
      t.text   :description

      t.boolean :authentication_required, null: false, default: false
      t.string :form_name

      t.integer :position

      t.references :product

      t.timestamps
    end

    add_reference :projects, :current_step, foreign_key: { to_table: :project_builder_steps }
  end
end
