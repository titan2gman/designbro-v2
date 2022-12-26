# frozen_string_literal: true

module DownloadHelpers
  TIMEOUT = 20
  PATH    = Rails.root.join('tmp/downloads')

  module_function

  def downloads
    Dir[PATH.join('*')]
  end

  def download
    downloads.first
  end

  def downloaded_file
    wait_for_download
    download
  end

  def wait_for_download
    Timeout.timeout(TIMEOUT) do
      sleep 0.1 until downloaded?
    end
  end

  def downloaded?
    !downloading? && downloads.any?
  end

  def downloading?
    downloads.grep(/\.crdownload$/).any?
  end

  def clear_downloads
    FileUtils.rm_f(downloads)
  end
end
