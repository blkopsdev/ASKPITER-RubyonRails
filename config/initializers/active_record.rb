class ActiveRecord::Base

  def type_name
    @type_name ||= self.class.base_class.name
  end

  def polymorphic_params as: nil, foreign_key: nil, foreign_type: nil
    as ||= type_name.demodulize.underscore unless foreign_key || foreign_type
    foreign_key ||= "#{as}_id"
    foreign_type ||= "#{as}_type"
    { foreign_key => id, foreign_type => type_name }.symbolize_keys
  end

end
