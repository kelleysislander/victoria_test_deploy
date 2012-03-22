ActiveRecord::Base.class_eval do
  def self.validate_date(*attr_names)
    options = attr_names.extract_options!
    validates_each(attr_names) do |record, attribute, value|
      begin
        Date.parse("#{attribute.to_s}")
        # Date.parse(attribute.to_s)
      # rescue ArgumentError
      rescue Exception => e
        record.errors[attribute] << "must be valid date #{attribute.to_s}, #{value}, #{e}"
      end
    end
  end
end

=begin

begin
  y = Date.parse("rodman was here")
rescue
  retVal = "nope not a date"
end

def convert_beg_date
  begin
    self.beg_date = Date.civil(self.year.to_i, self.month.to_i, self.day.to_i)
  rescue ArgumentError
    false
  end
end

def validate_beg_date
  errors.add("Beg Date", "is invalid.") unless convert_beg_date
end



http://stackoverflow.com/questions/6132642/rails-3-pass-a-parameter-to-custom-validation-method

ActiveRecord::Base.class_eval do
    def self.validates_obj_length(*attr_names)
        options = attr_names.extract_options!
        validates_each(attr_names, options) do |record, attribute, value|
          record.errors[attribute] << "Error: Length must be " + options[:length].to_s unless value.length == options[:length]
        end
    end
end

=end