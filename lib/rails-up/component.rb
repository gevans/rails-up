class RailsUp
  class Component
    attr_accessor :name,
                  :version,
                  :summary,
                  :roles,
                  :cookbooks,
                  :definition_file,
                  :cookbooks_path,
                  :roles_path

    def inspect1
      "<Component #{name} #{version} roles:#{roles.inspect}>"
    end

    def inspect
      inspect1
    end

    def roles
      @roles ||= []
    end

    def cookbooks
      @cookbooks ||= {}
    end

    def version=(value)
      @version = Gem::Version.new(value)
    end

    def cookbooks_path?
      !single_file? && cookbooks_path
    end

    def roles_path?
      !single_file? && roles_path
    end

    def single_file?
      if File.dirname(definition_file) =~ /\/components$/
        true
      else
        false
      end
    end

    def valid?
      begin
        validate
        true
      rescue RoleDefinitionError => e
        false
      end
    end

    def validate
      raise RailsUp::ComponentDefinitionError, "Name is required" if name.nil? || name.empty?
      raise RailsUp::ComponentDefinitionError, "Version is required" if version.nil? || version.version.empty?
    end

  end # Component
end # RailsUp
