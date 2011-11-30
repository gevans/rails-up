require 'active_support/ordered_hash'

class RailsUp
  module Components

    autoload :Definition,        "rails-up/components/definition"
    autoload :DefinitionBuilder, "rails-up/components/definition_builder"

    class << self
      def mappings
        @mappings ||= ActiveSupport::OrderedHash.new
      end

      ##
      # Attempts to load all components in the load path.
      # Awesome snippet repurposed from https://github.com/redcar/plugin_manager
      def load_components!
        $LOAD_PATH.each do |base|
          definition_files = Dir[File.join(File.expand_path("#{base}/.."), "components", "*", "component.rb")]
          definition_files.each do |file|
            begin
              definition = instance_eval(File.read(file))

              definition.definition_file = File.expand_path(file)
              definition.cookbooks_path = File.expand_path("#{File.dirname(file)}/cookbooks") if File.directory?("#{File.dirname(file)}/cookbooks")
              definition.roles_path = File.expand_path("#{File.dirname(file)}/roles") if File.directory?("#{File.dirname(file)}/roles")

              if RailsUp::Components.mappings.has_key?(definition.name)
                # TODO: Detect versions
                puts "Skipped duplicate component definition: #{file}"
              else
                RailsUp::Components.mappings[definition.name] = definition
              end
            rescue Object => e
              puts "Unreadable component definition: #{file}"
              puts "  " + e.message
              puts e.backtrace.map {|l| "  " + l}
              nil
            end
          end
        end
      end
    end

  end # Components
end # RailsUp
