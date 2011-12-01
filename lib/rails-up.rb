require 'thor'
require 'active_support/core_ext/string'

class RailsUp < Thor
  autoload :Version,    "rails-up/version"
  autoload :Components, "rails-up/components"
  autoload :Actions,    "rails-up/actions"

  include Thor::Actions
  include RailsUp::Actions

  add_runtime_options!

  def initialize(args=[], options={}, config={})
    RailsUp::Components.load_components!
    super
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
  def init(*args)
    if args.empty?
      say "Please specify components to use", :yellow
      return help("init")
    end

    if options.root?
      RailsUp.project_root = options[:root]
    end

    components = []
    args.each do |c|
      if RailsUp::Components.mappings.has_key?(c)
        components << RailsUp::Components.mappings[c]
      else
        say "Component is not loaded or does not exist: #{c}", :red
        return
      end
    end

    boot_after_create = yes?("Start Vagrant box afterward? [y/N]")

    say "Creating Vagrantfile..."
    template "Vagrantfile.tt", "#{RailsUp.project_root}/Vagrantfile"

    say "Creating chef directory..."
    empty_directory RailsUp.chef_root
    empty_directory RailsUp.cookbooks_path
    empty_directory RailsUp.roles_path
    copy_file "Cheffile", "#{RailsUp.chef_root}/Cheffile"

    components.each do |c|
      install_component(c)
    end

    say "Bundling cookbooks from Cheffile"
    inside RailsUp.chef_root do
      run "bundle exec librarian-chef install"
    end

    if boot_after_create
      say "Starting Vagrant..."
      inside RailsUp.project_root do
        run "vagrant up"
      end
    end

  end

  desc "-v, [version]", "Shows current rails-up version"
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

    def destination_root
      project_root
    end

    def templates_path
      @templates_path ||= File.expand_path("#{File.dirname(__FILE__)}/../templates")
    end

    def source_root
      templates_path
    end

    def chef_root
      @chef_root ||= "#{project_root}/chef"
    end

    def cookbooks_path
      @cookbooks_path ||= "#{chef_root}/cookbooks"
    end

    def roles_path
      @roles_path ||= "#{chef_root}/roles"
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
