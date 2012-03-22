
def validates_positive_or_zero(*attr_names)
  configuration = { :message_neg => "cannot be negative", :message_nil => "cannot be blank" }
  configuration.update(attr_names.pop) if attr_names.last.is_a?(Hash)
  validates_each attr_names do |m, a, v|
    if v.nil?
      m.errors.add(a, configuration[:message_nil])
    else
      m.errors.add(a, configuration[:message_neg]) if v < 0 
    end
  end
end

def validates_positive(*attr_names)
  configuration = { :message_zero => "Cannot be zero", :message_neg => "Cannot be negative" }
  configuration.update(attr_names.pop) if attr_names.last.is_a?(Hash)
  validates_each attr_names do |m, a, v| 
    m.errors.add(a, configuration[:message_zero]) if v == 0 
    m.errors.add(a, configuration[:message_neg])  if v < 0 
  end
end
