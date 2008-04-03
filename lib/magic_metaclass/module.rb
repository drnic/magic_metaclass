class Module
  alias :normal_const_missing :const_missing
  
  def const_missing(class_id)    
    begin
      return normal_const_missing(class_id)
    rescue
    end
    class_name = class_id.to_s
    unless class_name =~ /([A-Za-z_]+)(Metaclass|Class|Eigenclass|Eigen)/
      raise NameError.new("uninitialized constant #{class_id}")
    end
    base_class_name = $1
    begin
      base_class = self.const_get base_class_name
    rescue
      raise NameError.new("uninitialized constant #{class_id}")
    end
    metaclass = class << base_class; self; end
    self.const_set class_name, metaclass
  end
end