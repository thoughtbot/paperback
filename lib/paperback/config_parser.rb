require 'yaml'

module ConfigParser
  def self.parse(name)
    dir = File.dirname(__FILE__)
    yaml = File.read File.join(dir, 'config', "#{name}.yml")
    YAML.load(yaml)
  end
end
