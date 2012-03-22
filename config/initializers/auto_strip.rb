module ActiveRecord

  class Base
    # strips the value of the given attributes automatically
    def self.auto_strip(*attrs)
      attrs.each do |attr|
        define_method((attr.to_s + '=').to_sym) { |val| write_attribute attr, val.to_s.strip }
      end
    end
    
    # strips out hyphens
    def self.hyphen_strip(*attrs)
      attrs.each do |attr|
        define_method((attr.to_s + '=').to_sym) { |val| write_attribute attr, val.to_s.strip.gsub("-", "") }
      end
    end

    # upshifts the attributes passed in
    def self.upper(*attrs)
      attrs.each do |attr|
        define_method((attr.to_s + '=').to_sym) { |val| write_attribute attr, val.to_s.upcase }
      end
    end

    # strips out commas
    def self.comma_strip(*attrs)
      attrs.each do |attr|
        define_method((attr.to_s + '=').to_sym) { |val| write_attribute attr, val.to_s.strip.gsub(",", "") }
      end
    end

    # strips out slashes
    def self.slash_strip(*attrs)
      attrs.each do |attr|
        define_method((attr.to_s + '=').to_sym) { |val| write_attribute attr, val.to_s.strip.gsub("/", "").gsub("\\", "") }
      
      end
      
    end
    
  end
end