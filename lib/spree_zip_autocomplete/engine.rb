module SpreeZipAutocomplete
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_zip_autocomplete'

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    initializer "spree_zip_autocomplete.importmap", before: "importmap" do |app|
      app.config.importmap.paths << root.join("config/importmap.rb")
      app.config.importmap.cache_sweepers << root.join("app/assets/javascripts")
    end

    initializer 'spree_zip_autocomplete.autoloader' do |app|
      if Rails.autoloaders.zeitwerk_enabled?
        Rails.autoloaders.main.ignore("#{root}/app/overrides")
      end
    end

    config.to_prepare(&method(:activate).to_proc)
  end
end
