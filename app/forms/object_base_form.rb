# frozen_string_literal: true

class ObjectBaseForm
  include ActiveModel::Validations
  include Virtus.model

  attribute :object, Object

  def self.presents(name)
    @__name = name

    define_method name do
      record
    end
  end

  def save
    if valid?
      persist!
      record.errors.blank?
    else
      merge_errors!
      false
    end
  end

  def save!
    save || raise(ActiveRecord::RecordInvalid, record)
  end

  private

  def persist!
    raise(NotImplementedError)
  end

  def merge_errors!
    errors.each do |attribute, error|
      record.errors.add(attribute, error)
    end
  end

  def record
    @record ||= record_by_name
  end

  def record_by_name
    model_name = self.class.instance_variable_get(:@__name)
    model_class = model_name.to_s.singularize.camelize.constantize

    raise(ActiveRecord::RecordInvalid, object) unless object.is_a?(model_class)

    object
  end

  # rubocop:disable Style/MissingRespondToMissing
  def method_missing(name)
    record.public_send(name)
  end
  # rubocop:enable Style/MissingRespondToMissing
end
