class AttachInspirationsToProjects < ActiveRecord::Migration[5.2]
  def change
    add_reference :inspirations, :project, index: true, foreign_key: true
    add_reference :existing_designs, :project, index: true, foreign_key: true

    reversible do |dir|
      dir.up do
        Project.find_each do |project|
          project.brand.inspirations.all.each do |i|
            inspiration_image = i.inspiration_image.dup
            inspiration_image.assign_attributes(
              created_at: i.inspiration_image.created_at,
              updated_at: i.inspiration_image.updated_at
            )
            inspiration_image.save!(validate: false)

            inspiration = i.dup
            inspiration.brand_id = nil
            inspiration.project = project
            inspiration.inspiration_image = inspiration_image
            inspiration.save!(validate: false)
          end

          project.brand.existing_designs.all.each do |ed|
            existing_logo = ed.existing_logo.dup
            existing_logo.assign_attributes(
              created_at: ed.existing_logo.created_at,
              updated_at: ed.existing_logo.updated_at
            )
            existing_logo.save!(validate: false)

            existing_design = ed.dup
            existing_design.brand_id = nil
            existing_design.project = project
            existing_design.existing_logo = existing_logo
            existing_design.save!(validate: false)
          end
        end
      end

      dir.down do
      end
    end

    remove_reference :inspirations, :brand, index: true, foreign_key: true
    remove_reference :existing_designs, :brand, index: true, foreign_key: true

    Inspiration.where(project_id: nil).destroy_all
    ExistingDesign.where(project_id: nil).destroy_all
  end
end
