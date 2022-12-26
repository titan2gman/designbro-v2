# frozen_string_literal: true

module NewProject
  class PackagingStepForm < NewProject::StepBaseForm
    presents :project

    attribute :packaging_type, String
    attribute :client, Client

    attribute :width, String
    attribute :height, String
    attribute :volume, String
    attribute :diameter, String

    attribute :label_width, String
    attribute :label_height, String

    attribute :side_depth, String
    attribute :front_width, String
    attribute :front_height, String

    attribute :technical_drawing_id, Integer

    validates :packaging_type, presence: true

    validates :height, :width, presence: true, if: :validate_pouch_property_presence?
    validates :height, :volume, :diameter, presence: true, if: :validate_can_property_presence?
    validates :label_width, :label_height, presence: true, if: :validate_label_property_presence?
    validates :label_width, :label_height, presence: true, if: :validate_bottle_property_presence?
    validates :front_width, :front_height, :side_depth, presence: true, if: :validate_card_box_property_presence?

    validate :technical_drawing_presence

    private

    def persist!
      project.packaging_measurements&.destroy unless project.packaging_type.to_s == packaging_type

      return if packaging_type == 'other'

      new_packaging_measurements = packaging_measurements
      new_packaging_measurements.save(validate: validate_form?)

      project.assign_attributes packaging_measurements: new_packaging_measurements

      # project.client = client if client

      project.save

      update_step
    end

    def packaging_measurements
      params = send("#{packaging_type}_packaging_measurements_params")

      measurements = if project.packaging_type.to_s == packaging_type
                       old_packaging_measurements = project.packaging_measurements
                       old_packaging_measurements.assign_attributes(params)
                       old_packaging_measurements
                     else
                       "#{packaging_type.camelize}PackagingMeasurements".constantize.new params
                     end

      measurements&.technical_drawing = @technical_drawing

      measurements
    end

    def can_packaging_measurements_params
      {
        diameter: diameter,
        height: height,
        volume: volume
      }
    end

    def bottle_packaging_measurements_params
      {
        label_height: label_height,
        label_width: label_width
      }
    end

    def label_packaging_measurements_params
      {
        label_height: label_height,
        label_width: label_width
      }
    end

    def card_box_packaging_measurements_params
      {
        front_height: front_height,
        front_width: front_width,
        side_depth: side_depth
      }
    end

    def pouch_packaging_measurements_params
      {
        height: height,
        width: width
      }
    end

    def plastic_pack_packaging_measurements_params
      {}
    end

    ['can', 'label', 'bottle', 'card_box', 'pouch'].each do |pack_type|
      define_method("validate_#{pack_type}_property_presence?") do
        validate_form? && packaging_type == pack_type && technical_drawing_id_does_not_exist?
      end
    end

    def technical_drawing_id_does_not_exist?
      technical_drawing_id.nil? || (technical_drawing_id.is_a?(String) && technical_drawing_id.empty?)
    end

    def technical_drawing_presence
      form_fields = case packaging_type
                    when 'can'
                      [:height, :volume, :diameter]
                    when 'bottle'
                      [:label_height, :label_width]
                    when 'label'
                      [:label_height, :label_width]
                    when 'card_box'
                      [:front_width, :front_height, :side_depth]
                    when 'pouch'
                      [:height, :width]
                    else
                      []
                    end

      has_error = errors.inject(false) do |has_error_inner, pair|
        has_error_inner || form_fields.include?(pair.first)
      end || form_fields.empty?

      @technical_drawing = UploadedFile::TechnicalDrawing.find_by id: technical_drawing_id
      errors.add(:technical_drawing_id, :blank) if has_error && @technical_drawing.nil? && validate_form?
    end

    def validate_form?
      upgrade_project_state || !project.draft?
    end
  end
end
