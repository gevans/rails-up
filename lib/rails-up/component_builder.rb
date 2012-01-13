class RailsUp
  class ComponentBuilder

    def initialize(&block)
      @block = block
      @definition = Component.new
    end

    def build
      instance_eval(&@block)
      @definition.validate
      @definition
    end

    def name(value)
      @definition.name = value.to_s
    end

    def version(value)
      @definition.version = Gem::Version.new(value)
    end

    def summary(value)
      @definition.summary = value
    end

    def roles(*value)
      @definition.roles = value
    end

    def cookbook(name, value={})
      @definition.cookbooks[name] = value
    end

    def role(name, &block)
      role = Components::RoleBuilder.new(&block)
      role.name = name
      @definition.roles << role.build
    end

  end # ComponentBuilder
end # RailsUp
