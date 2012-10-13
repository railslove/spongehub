class ApplicationSettings

  class NestedConfiguration < ActiveSupport::Configurable::Configuration
    def initialize(config_key)
      @config_key = config_key
      super
    end

    def method_missing(name, *args)
      if name.to_s =~ /(.*)=$/
        self[$1] = args.first
      else
        if self.has_key?(name)
          self[name]
        else
          raise "Missing configuration key '#{name}'' for '#{@config_key}'"
        end
      end
    end
  end

  def self.load!
    load_from_settings_file!
  end

  protected

  def self.config_path
    @config_path ||= Rails.root.join('config/settings.yml')
  end

  # Tries to load data from a settings file
  def self.load_from_settings_file!
    data = YAML.load_file(config_path) rescue {}
    store_config_hash!(Rails.application.config, data[Rails.env], 'config')
  end

  def self.store_config_hash!(conf_object, hash, config_key)
    hash ||= {}
    hash.each do |key, value|
      if value.kind_of?(Hash)
        nested_config_key = [config_key, key].join('.')
        conf_object.send("#{key}=", NestedConfiguration.new(nested_config_key))
        self.store_config_hash!(conf_object.send(key), value, nested_config_key)
      else
        conf_object.send("#{key}=", value)
      end
    end
  end
end

ApplicationSettings.load!