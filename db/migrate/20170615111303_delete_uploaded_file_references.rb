# frozen_string_literal: true

class DeleteUploadedFileReferences < ActiveRecord::Migration[5.0]
  def change
    remove_column(:project_source_files,         :source_file_id)
    remove_column(:project_existing_logos,       :existing_logo_id)
    remove_column(:project_competitors,          :competitor_logo_id)
    remove_column(:project_inspirations,         :inspiration_image_id)
    remove_column(:project_additional_documents, :additional_document_id)

    remove_column(:can_packaging_measurements,          :technical_drawing_id)
    remove_column(:label_packaging_measurements,        :technical_drawing_id)
    remove_column(:pouch_packaging_measurements,        :technical_drawing_id)
    remove_column(:bottle_packaging_measurements,       :technical_drawing_id)
    remove_column(:card_box_packaging_measurements,     :technical_drawing_id)
    remove_column(:plastic_pack_packaging_measurements, :technical_drawing_id)
  end
end
