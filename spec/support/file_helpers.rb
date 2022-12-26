# frozen_string_literal: true

module FileHelpers
  def file_to_upload
    fixture_file_upload('spec/factories/files/test.png', 'image/png')
  end
end
