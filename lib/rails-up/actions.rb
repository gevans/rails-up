require 'active_support/concern'

class RailsUp
  module Actions
    extend ActiveSupport::Concern

    module InstanceMethods

      def install_component(component)
        prepare_cheffile(component)
        copy_roles(component)
      end

      ##
      # Please God, refactor me!
      def prepare_cheffile(component)
        say "Adding #{component.name} cookbooks..."

        directory component.cookbooks_path, RailsUp.cookbooks_path if component.roles_path?

        cookbooks = []
        component.cookbooks.each do |k,v|
          if v.empty?
            cookbooks << "\ncookbook #{k.inspect}"
          else
            cookbooks << "\ncookbook #{k.inspect},"
          end
          params = v.to_a
          params_total = params.length
          params.each_index do |i|
            param  = "  :#{params[i][0]} => #{params[i][1].inspect}"
            param += "," if i < params_total - 1
            cookbooks << param
          end
        end
        append_to_file "#{RailsUp.chef_root}/Cheffile", cookbooks.join("\n")
      end

      def copy_roles(component)
        say "Copying #{component.name} roles..."

        directory component.roles_path, RailsUp.roles_path if component.roles_path?

        component.roles.each do |r|
          if r.is_a?(Components::ChefRole)
            create_file "#{RailsUp.roles_path}/#{r.name}.rb", r.to_s
          end
        end
      end

    end # InstanceMethods
  end # Actions
end # RailsUp