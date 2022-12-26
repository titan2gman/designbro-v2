# frozen_string_literal: true

class ZipArchiver
  include Callable

  attr_reader :files

  def initialize(files)
    @files = files
  end

  def call
    files.map do |file|
      filename = get_filename(file.original_filename, file.file_identifier)

      [file.file, filename]
    end
  end

  private

  def original_filenames
    @original_filenames ||= files.map(&:original_filename).each_with_object(
      Hash.new(0)
    ) do |string, hash|
      hash[string] += 1
    end
  end

  def get_filename(original_filename, unique_filename)
    if original_filenames[original_filename] > 1
      original_basename = File.basename(original_filename, File.extname(original_filename))
      "#{original_basename}_#{unique_filename}"
    else
      original_filename
    end
  end
end
