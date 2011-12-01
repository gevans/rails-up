class RailsUp
  module Components
    class Definition

      attr_accessor :name,
                    :version,
                    :summary,
                    :description,
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

    end # Definition
  end # Components
end # RailsUp
