class AddProjectRelatedQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :project_builder_questions, :mandatory, :boolean, null: false, default: false
    rename_column :project_builder_steps, :required_for_one_to_one, :mandatory
  end
end
