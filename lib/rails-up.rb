require 'thor'
require 'active_support/core_ext/string'

class RailsUp < Thor

  autoload :Version, "rails-up/version"
  autoload :Component, "rails-up/component"
  autoload :ComponentBuilder, "rails-up/component_builder"
  autoload :Components, "rails-up/components"
  autoload :Actions, "rails-up/actions"
  autoload :Helpers, "rails-up/helpers"

  require "rails-up/errors"

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
  method_option "box", :default => "base", :aliases => "-b", :type => :string, :desc => "Vagrant box"
  method_option "url", :type => :string, :desc => "Vagrant box URL"
  def init(*args)
    if args.empty?
      say "Please specify components to use", :yellow
      return help("init")
    end

    RailsUp.project_root = options[:root] if options.root?

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
    template "Vagrantfile.tt", "#{RailsUp.project_root}/Vagrantfile", vagrantfile_options(components, options[:box], options[:url])

    say "Creating Cheffile..."
    copy_file "Cheffile", "#{RailsUp.project_root}/#{RailsUp.chef_root}/Cheffile"

    components.each do |c|
      install_component(c)
    end

    say "Bundling cookbooks from Cheffile"
    inside "#{RailsUp.project_root}/#{RailsUp.chef_root}" do
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

    def vagrantfile_options(components, box_name, box_url)
      forward_ports = {}
      components.each do |c|
        forward_ports.merge!(c.forward_ports)
      end

      {
        :cookbooks_path => RailsUp.cookbooks_path,
        :roles_path     => RailsUp.roles_path,
        :components     => components,
        :forward_ports  => forward_ports,
        :box_name       => box_name,
        :box_url        => box_url
      }
    end

  class << self
    def project_root
      @project_root ||= '.'
    end

    def project_root=(root)
      @project_root = root
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
      @chef_root ||= "chef"
    end

    def cookbooks_path
      @cookbooks_path ||= "#{chef_root}/cookbooks"
    end

    def roles_path
      @roles_path ||= "#{chef_root}/roles"
    end

    def component(&block)
      builder = RailsUp::ComponentBuilder.new(&block)
      builder.build
    end
  end

end # RailsUp
