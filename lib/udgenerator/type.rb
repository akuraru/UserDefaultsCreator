module Udgenerator
	class Type
		def initialize()
		end
		def == (type)
			true
		end
		def type_name
			"Type"
		end
		def defaultValue
			""
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
	end
	class NSDate < NSObject
		def == (type)
			NSDate === type && super(type)
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
