class CreateProjectAdditionalDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :project_additional_documents do |t|
      t.string :comment

      t.references :project, foreign_key: true

      t.references :additional_document, foreign_key: { to_table: :uploaded_files }

      t.timestamps
    end
  end
end
