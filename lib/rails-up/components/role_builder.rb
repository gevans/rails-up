class RailsUp
  module Components
    class RoleBuilder

      def initialize(&block)
        @block = block
        @definition = Components::Role.new
      end

      def build
        instance_eval(&@block)
        @definition.validate
        @definition
      end

      def name=(value)
        @definition.name = value
      end

      def name(value)
        @definition.name = value
      end

      def description(value)
        @definition.description = value
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
