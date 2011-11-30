require 'thor'
require 'fileutils'

class RailsUp < Thor
  autoload :Version, "rails-up/version"

  desc "init", "Creates a new Vagrant file and copies cookbooks to current path"
  def init
    require "fileutils"

    FileUtils.cp(
      File.join(RailsUp.templates_path, "Vagrantfile"),
      File.join(RailsUp.project_path, "Vagrantfile")
    )
    puts "Created: Vagrantfile"

    FileUtils.cp_r(
      File.join(RailsUp.templates_path, "chef"),
      File.join(RailsUp.project_path, "chef")
    )
    puts "Created: chef/"
  end

  desc "version", "Shows current rails-up version"
  def version
    puts "rails-up #{RailsUp::Version::STRING}"
  end
  map "-v" => "version"

  class << self
    def project_path
      @_project_path ||= FileUtils.pwd
    end

    def templates_path
      @_templates_path ||= File.expand_path("#{File.dirname(__FILE__)}/../templates")
    end
  end # self
end # RailsUp
