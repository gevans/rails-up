require 'active_support/ordered_hash'

class RailsUp
  module Components

    autoload :Role, "rails-up/components/role"
    autoload :RoleBuilder, "rails-up/components/role_builder"

    class << self
      def mappings
        @mappings ||= ActiveSupport::OrderedHash.new
      end

      ##
      # Attempts to require all components in the load path.
      # Awesome snippet repurposed from https://github.com/redcar/plugin_manager
      def load_components!
        $LOAD_PATH.each do |base|
          definition_files = Dir[File.join(File.expand_path("#{base}/.."), "components", "{*/component.rb,*_component.rb}")]
          definition_files.each do |file|
            begin
              definition = instance_eval(File.read(file))

              definition.definition_file = File.expand_path(file)

              if !definition.single_file?
                definition.cookbooks_path = File.expand_path("#{File.dirname(file)}/cookbooks") if File.directory?("#{File.dirname(file)}/cookbooks")
                definition.roles_path = File.expand_path("#{File.dirname(file)}/roles") if File.directory?("#{File.dirname(file)}/roles")
              end

              if RailsUp::Components.mappings.has_key?(definition.name)
                # TODO: Detect/differentiate versions of multiple components
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
