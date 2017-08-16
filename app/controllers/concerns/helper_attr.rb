module HelperAttr
  extend ActiveSupport::Concern

  class_methods do

    def helper_attr *attrs
      attrs.flatten!
      attr_accessor *attrs
      helper_method *attrs
    end

  end
end
