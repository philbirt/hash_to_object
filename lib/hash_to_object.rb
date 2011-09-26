require 'active_support/inflector'

module HashToObject
  VERSION = '0.1.0'

  class << self
    alias_method :build_new_object, :build_new_object
  end
  
  def objectify(hash_parameters)
    hash_parameters.each do |key, value|
      if value.is_a?(Array)
        objects = value.map{|item| build_new_object(build_class_string(key), item)}
        define_attribute(key, objects)
      elsif value.is_a?(Hash)
        define_attribute(key, build_new_object(build_class_string(key), value))
      else
        define_attribute(key.to_s, value)
      end
    end
  end

  def build_class_string(class_string)
    @settings ||= load_settings
    class_string = class_string.singularize.underscore

    if @settings && @settings.send(class_string.to_sym)
      @settings.send(class_string.to_sym)
    else
      "#{self.class}::#{class_string.singularize.camelcase}"
    end
  end
  
  def build_new_object(class_string, hash_parameters)
    class_string.constantize.new(hash_parameters)
  end

  def define_attribute(key, value)
    metaclass.send :attr_accessor, key.underscore
    send "#{key}=".underscore.to_sym, value    
  end

  def metaclass
    class << self
      self
    end
  end

  def load_settings
    #implement this
    nil
  end
end
