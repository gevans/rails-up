require 'thor'
require 'active_support/core_ext/string'
require 'fileutils'

class RailsUp < Thor
  autoload :Version,    "rails-up/version"
  autoload :Components, "rails-up/components"

  include Thor::Actions

  def initialize(*args)
    super
    RailsUp::Components.load_components!
  end

  def help(task=nil, subcommand=false)
    super

    if task.nil? || task == "init"
      say if task == "init"
      components_listing
    end
  end

  desc "init [COMPONENTS ...]", "Creates a new Vagrantfile and copies cookbooks to current path"
  method_option "root", :default => ".", :aliases => "-r", :type => :string, :desc => "Project root"
  # method_option "box", :default => "lucid32", :desc => "Vagrant box name to use"
  # method_option "box-url", :default => "http://files.vagrantup.com/lucid32.box", :desc => "URL to specified Vagrant box"
  def init(*components)
    if components.empty?
      say "Please specify components to use", :yellow
      return help("init")
    end

    if options.root?
      RailsUp.project_root = options[:root]
    end

    components.each do |c|
      if !RailsUp::Components.mappings.has_key?(c)
        say "Component is not loaded or does not exist: #{c}", :red
        return
      end
    end
  end

  desc "-v, version", "Shows current rails-up version"
  def version
    say "rails-up #{RailsUp::Version::STRING}"
  end
  map "-v" => "version"

  class << self
    def project_root
      @project_root ||= FileUtils.pwd
    end

    def project_root=(path)
      @project_root = File.expand_path(path)
    end

    def templates_path
      @templates_path ||= File.expand_path("#{File.dirname(__FILE__)}/../templates")
    end

    def cookbooks_path
      @cookbooks_path ||= File.expand_path("#{project_path}/chef/cookbooks")
    end

    def roles_path
      @cookbooks_path ||= File.expand_path("#{project_path}/chef/roles")
    end

    def component(&block)
      builder = RailsUp::Components::DefinitionBuilder.new(&block)
      builder.build
    end
  end

  protected

    def components_listing
      components = ActiveSupport::OrderedHash.new
      RailsUp::Components.mappings.each do |name, cm|
        components["  #{name}"] = "# #{cm.summary}"
      end

      say "Components: "
      say
      print_table(components, :indent => 2, :truncate => true)
    end

end # RailsUp
