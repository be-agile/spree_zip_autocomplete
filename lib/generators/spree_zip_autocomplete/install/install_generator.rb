module SpreeZipAutocomplete
  module Generators
    class InstallGenerator < Rails::Generators::Base
      def add_javascripts
        js_directory = SpreeZipAutocomplete::Engine.root.join('app', 'assets', 'javascripts')
        manifest_file = 'app/assets/config/manifest.js'
        Dir.glob("#{js_directory}/**/*.js").each do |file|
          relative_path = file.sub("#{js_directory.to_s}/", '')
          append_file manifest_file, "//= link #{relative_path}\n"
        end
      end
    end
  end
end
