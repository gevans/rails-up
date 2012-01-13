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
        definition_files = $LOAD_PATH.collect do |base|
          Dir[File.join(File.expand_path("#{base}/.."), "components", "{*/component.rb,*_component.rb}")]
        end

        # Search ~/.rails-up for user components
        definition_files << Dir[File.join(File.expand_path("#{ENV['HOME']}"), ".rails-up", "components", "{*/component.rb,*_component.rb}")]

        definition_files.flatten.each do |file|
          begin
            definition = instance_eval(File.read(file))

            definition.definition_file = File.expand_path(file)

            if !definition.single_file?
              definition.cookbooks_path = File.expand_path("#{File.dirname(file)}/cookbooks") if File.directory?("#{File.dirname(file)}/cookbooks")
              definition.roles_path = File.expand_path("#{File.dirname(file)}/roles") if File.directory?("#{File.dirname(file)}/roles")
            end

            if self.mappings.has_key?(definition.name) && self.mappings[definition.name].version >= definition.version
              puts "Skipped duplicate component definition: #{file}"
            else
              self.mappings[definition.name] = definition
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

  end # Components
end # RailsUp
