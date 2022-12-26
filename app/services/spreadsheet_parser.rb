# frozen_string_literal: true

class SpreadsheetParser
  include Callable
  include Wisper::Publisher

  SUPPORTED_FORMATS = ['xls', 'xlsx'].freeze

  def initialize(file)
    @file = file
  end

  def call
    return broadcast(:no_file_specified) unless @file
    return broadcast(:incorrect_file_extension) unless file_extension_valid?

    (3..spreadsheet.last_row).map { |index| spreadsheet.row(index) }
  end

  private

  def file_extension_valid?
    SUPPORTED_FORMATS.include? file_extension
  end

  def file_extension
    @file_extension ||= File.extname(@file.original_filename).delete('.')
  end

  def spreadsheet
    @spreadsheet ||= begin
      case file_extension
      when 'csv'  then Roo::Csv.new(@file.path, file_warning: :ignore)
      when 'xls'  then Roo::Excel.new(@file.path, file_warning: :ignore)
      when 'xlsx' then Roo::Excelx.new(@file.path, file_warning: :ignore)

      else raise "Unknown file type: #{@file.original_filename}"
      end
    end
  end
end
