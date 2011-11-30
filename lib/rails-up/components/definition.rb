class RailsUp
  module Components
    class Definition

      attr_accessor :name,
                    :version,
                    :summary,
                    :description,
                    :roles,
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

    end # Definition
  end # Components
end # RailsUp
