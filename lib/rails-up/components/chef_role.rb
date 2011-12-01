class RailsUp
  module Components
    class ChefRole

      attr_accessor :name,
                    :description,
                    :run_list,
                    :env_run_lists,
                    :default_attributes,
                    :override_attributes

      def inspect1
        "<Role #{name} #{run_list.inspect}>"
      end

      def inspect
        inspect1
      end

      def to_s
        role  = "name #{name.to_s.inspect}\n"
        role += "description #{description.inspect}\n" if description
        role += array_to_args("run_list", run_list) + "\n" if run_list
        role += array_to_args("env_run_lists", env_run_lists) + "\n" if env_run_lists
        role += "default_attributes(#{default_attributes.inspect})\n" if default_attributes
        role += "override_attributes(#{override_attributes.inspect})\n" if override_attributes
        role
      end

      private

        def array_to_args(method, array=[])
          return if array.empty?
          args = ""
          array.compact.each_index do |i|
            args += "," if i != 0
            args += " #{array[i].inspect}"
          end
          "#{method}#{args}"
        end

    end # Definition
  end # Components
end # RailsUp
