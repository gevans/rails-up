class RailsUp
  module Components
    class ChefRoleBuilder

      def initialize(&block)
        @block = block
        @definition = Components::ChefRole.new
      end

      def build
        instance_eval(&@block)
        @definition
      end

      def name=(value)
        value = value.to_sym if value.is_a?(String)
        @definition.name = value
      end

      def run_list(*value)
        @definition.run_list = value
      end

      def env_run_lists(*value)
        @definition.env_run_lists = value
      end

      def default_attributes(value)
        @definition.default_attributes = value
      end

      def override_attributes(value)
        @definition.override_attributes = value
      end

    end # DefinitionBuilder
  end # Components
end # RailsUp
