# frozen_string_literal: true

class BaseForm
  include ActiveModel::Validations
  include Virtus.model

  attribute :id, Integer

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
    model_name ||= self.class.name.gsub('Form', '')

    model_class = model_name.to_s.singularize.camelize.constantize

    if id
      model_class.find(id)
    else
      model_class.new
    end
  end
end
