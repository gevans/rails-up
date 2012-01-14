require 'active_support/concern'

class RailsUp
  module Helpers
    extend ActiveSupport::Concern

    module InstanceMethods

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

    end # InstanceMethods

  end # Helpers
end # RailsUp