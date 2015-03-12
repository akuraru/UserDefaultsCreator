module Udgenerator
	class Type
		attr_accessor :name

		def initialize(name)
			@name = name
		end
		def == (type)
			@name == type.name
		end
		def capitalize
			c = @name
			c[0,1].capitalize + c[1..-1]
		end
		def define
			"k" + self.capitalize
		end
		def to_nsstring
			'@"' + @name + '"'
		end
		def type_name
			"Type"
		end
		def getter
			"- (#{self.type_name})#{self.name}"
		end
		def interface_getter
			self.getter + ";\n"
		end
		def setter
			"- (void)set#{self.capitalize}:(#{self.type_name})#{self.name}"
		end
		def interface_setter
			self.setter + ";\n"
		end
		def interface
			self.interface_getter + interface_setter
		end
		def imp_define
			"\#define #{self.define} #{self.to_nsstring}\n"
		end
		def defaultValue
			""
		end
		def register_default
			"#{self.define} : #{self.defaultValue}"
		end
		def imp_set_message
			""
		end
		def typeExchange(obj)
			obj
		end
		def objectExchange(obj)
			obj
		end
		def inImpGetter
			"    return [defaults #{self.imp_get_message}:#{self.define}];\n"
		end
		def impGetter
			"#{self.getter} \{\n#{self.inImpGetter}\}\n"
		end
		def inImpSetter
			"    [defaults #{self.imp_set_message}:#{self.name} forKey:#{self.define}];\n    [defaults synchronize];\n"
		end
		def impSetter
			"#{self.setter} \{\n#{self.inImpSetter}\}\n"
		end
		def property
			"@property #{self.type_name} #{self.name};\n"
		end
	end
	class NSObject < Type
		def == (type)
			NSObject === type && super(type)
		end
		def type_name
			"id"
		end
		def imp_get_message
			"objectForKey"
		end
		def imp_set_message
			"setObject"
		end
	end
	class NSString < NSObject
		def == (type)
			NSString === type && super(type)
		end
		def type_name
			"NSString *"
		end
		def defaultValue
			"@\"\""
		end
	end
	class NSNumber < NSObject
		def == (type)
			NSNumber === type && super(type)
		end
		def type_name
			"NSNumber *"
		end
		def defaultValue
			"\@0"
		end
	end
	class NSArray < NSObject
		def == (type)
			NSArray === type && super(type)
		end
		def type_name
			"NSArray *"
		end
		def defaultValue
			"@[]"
		end
	end
	class NSDictionary < NSObject
		def == (type)
			NSDictionary === type && super(type)
		end
		def type_name
			"NSDictionary *"
		end
		def defaultValue
			"@{}"
		end
	end
	class NSData < NSObject
		def == (type)
			NSData === type && super(type)
		end
		def type_name
			"NSData *"
		end
		def register_default
			""
		end
	end
	class NSDate < NSObject
		def == (type)
			NSData === type && super(type)
		end
		def type_name
			"NSDate *"
		end
		def defaultValue
			"[NSDate date]"
		end
	end
	class NSValue < Type
		def == (type)
			NSValue === type && super(type)
		end
		def type_name
			"NSValue"
		end
		def defaultValue
			"@0"
		end
		def typeExchange(obj)
			"[#{obj} integerValue]"
		end
		def objectExchange(value)
			"@(#{value})"
		end
	end
	class NSInteger < NSValue
		def == (type)
			NSInteger === type && super(type)
		end
		def type_name
			"NSInteger"
		end
		def imp_get_message
			"integerForKey"
		end
		def imp_set_message
			"setInteger"
		end
		def typeExchange(obj)
			"[#{obj} integerValue]"
		end
	end
	class NSBOOL < NSValue
		def == (type)
			NSBOOL === type && super(type)
		end
		def type_name
			"BOOL"
		end
		def imp_get_message
			"boolForKey"
		end
		def imp_set_message
			"setBool"
		end
		def typeExchange(obj)
			"[#{obj} boolValue]"
		end
	end
	class NSFloat < NSValue
		def == (type)
			NSFloat === type && super(type)
		end
		def type_name
			"float"
		end
		def imp_get_message
			"floatForKey"
		end
		def imp_set_message
			"setFloat"
		end
		def typeExchange(obj)
			"[#{obj} floatValue]"
		end
	end
	class NSDouble < NSValue
		def == (type)
			NSDouble === type && super(type)
		end
		def type_name
			"double"
		end
		def imp_get_message
			"doubleForKey"
		end
		def imp_set_message
			"setDouble"
		end
		def typeExchange(obj)
			"[#{obj} doubleValue]"
		end
	end
end
