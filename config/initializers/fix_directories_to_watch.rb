# frozen_string_literal: true

# https://github.com/rails/rails/issues/32700

# ** ERROR: directory is already being watched! **

# Directory: /Users/taras/Documents/designbro/designbro-v2/node_modules/.bin/compression-webpack-plugin

# is already being watched through: /Users/taras/Documents/designbro/designbro-v2/node_modules/compression-webpack-plugin

# MORE INFO: https://github.com/guard/listen/wiki/Duplicate-directory-errors
# ** ERROR: directory is already being watched! **

# Directory: /Users/taras/Documents/designbro/designbro-v2/node_modules/.bin/mini-css-extract-plugin

# is already being watched through: /Users/taras/Documents/designbro/designbro-v2/node_modules/mini-css-extract-plugin

# MORE INFO: https://github.com/guard/listen/wiki/Duplicate-directory-errors

module ActiveSupport
  class EventedFileUpdateChecker
    private

    def directories_to_watch
      dtw = (@files + @dirs.keys).map { |f| @ph.existing_parent(f) }
      dtw.compact!
      dtw.uniq!

      normalized_gem_paths = Gem.path.map { |path| File.join path, '' }
      dtw = dtw.reject do |path|
        normalized_gem_paths.any? { |gem_path| path.to_s.start_with?(gem_path) }
      end

      dtw.delete Rails.root # added for me

      @ph.filter_out_descendants(dtw)
    end
  end
end
