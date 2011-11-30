class RailsUp
  module Components
    class DefinitionBuilder

      def initialize(&block)
        @block = block
        @definition = Components::Definition.new
      end

      def build
        instance_eval(&@block)
        @definition
      end

      def name(value)
        @definition.name = value
      end

      def version(value)
        @definition.version = value
      end

      def summary(value)
        @definition.summary = value
      end

      def description(value)
        @definition.description = value
      end

      def roles(*value)
        @definition.roles = value
      end

    end # DefinitionBuilder
  end # Components
end # RailsUp