# frozen_string_literal: true

ActiveAdmin.register UploadedFile::BrandExample, as: 'Brand Example' do
  config.filters = false

  permit_params :file, :original_filename

  controller do
    def scoped_collection
      query_select_argument = '
        uploaded_files.*,

        count(case project_brand_examples.example_type when 1 then 1 else null end) as bad_project_brand_examples_count,
        count(case project_brand_examples.example_type when 2 then 1 else null end) as good_project_brand_examples_count,
        count(case project_brand_examples.example_type when 0 then 1 else null end) as skip_project_brand_examples_count
      '

      super.left_joins(:project_brand_examples)
           .select(query_select_argument)
           .group('uploaded_files.id')
    end
  end

  index do
    id_column

    column 'Name', :original_filename

    column 'Image', :file do |brand_example|
      image(brand_example.file, 'small')
    end

    column 'Good',    :good_project_brand_examples_count, sortable: true
    column 'Bad',     :bad_project_brand_examples_count,  sortable: true
    column 'Skipped', :skip_project_brand_examples_count, sortable: true

    column :created_at
    column :updated_at
    actions
  end

  show do |brand_example|
    attributes_table do
      row('Name') { brand_example.original_filename }
      row(:file) { image(brand_example.file) }

      row('Good')    { brand_example.project_brand_examples.good.count }
      row('Bad')     { brand_example.project_brand_examples.bad.count  }
      row('Skipped') { brand_example.project_brand_examples.skip.count }

      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs do
      f.input :original_filename, label: 'Name'
      f.input :file, as: :file, hint: image(object.file)
    end

    f.actions
  end
end
