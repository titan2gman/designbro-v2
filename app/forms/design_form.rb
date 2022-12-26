# frozen_string_literal: true

class DesignForm < BaseForm
  include Wisper::Publisher

  presents :design

  attribute :project, Project
  attribute :rating, Integer
  attribute :finalist, Boolean
  attribute :stationery_approved, Boolean
  attribute :uploaded_file, UploadedFile::DesignFile
  attribute :spot, Spot
  attribute :name, String

  def update
    if valid?
      persist_update!
      record.errors.blank?
    else
      merge_errors!
      false
    end
  end

  def update!
    update || raise(ActiveRecord::RecordInvalid, record)
  end

  private

  def persist!
    design.assign_attributes(params)
    design.save!
    spot.upload_design!

    project.finalist_stage! if project.one_to_one?

    broadcast(:new_design_uploaded, design)
    broadcast(:send_designer_stats_entity, design)
  end

  def persist_update!
    design.update(rating: rating) if rating

    if project
      if finalist && project.design_stage?
        design.spot.mark_as_finalist!

        project.finalist_stage! if project.all_finalists_selected?
      end

      design.spot.approve_stationery! if stationery_approved
    end

    if uploaded_file
      design.update!(uploaded_file_params)
      design.spot.upload_stationery! if design.spot.stationery?

      broadcast(:new_design_uploaded, design)
    end

    broadcast(:send_designer_stats_entity, design)
  end

  def params
    {
      uploaded_file: uploaded_file,
      spot: spot,
      name: name
    }
  end

  def uploaded_file_params
    {
      uploaded_file: uploaded_file,
      name: name
    }
  end
end
