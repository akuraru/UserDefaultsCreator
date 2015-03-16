module Udgenerator
	class Core
		def capitalize(str)
			str[0,1].capitalize + str[1..-1]
		end
		def define(str)
			"k" + capitalize(str)
		end
		def to_nsstring(str)
			'@"' + str + '"'
		end
		def getter(key, value)
			"- (#{value.type_name})#{key}"
		end
		def interface_getter(key, value)
			getter(key, value) + ";\n"
		end
		def setter(key, value)
			"- (void)set#{capitalize(key)}:(#{value.type_name})#{key}"
		end
		def interface_setter(key, value)
			setter(key, value) + ";\n"
		end
		def interface(key, value)
			interface_getter(key, value) + interface_setter(key, value)
		end
		def imp_define(key, value)
			"\#define #{define(key)} #{to_nsstring(key)}\n"
		end
		def register_default(key, value)
			if (0 < value.defaultValue.length ) then
				"#{define(key)} : #{value.defaultValue}"
			else
				""
			end
		end
		def in_imp_getter(key, value)
			"    return [defaults #{value.imp_get_message}:#{define(key)}];\n"
		end
		def impGetter(key, value)
			"#{getter(key, value)} \{\n#{in_imp_getter(key, value)}\}\n"
		end
		def in_imp_setter(key, value)
			"    [defaults #{value.imp_set_message}:#{key} forKey:#{define(key)}];\n    [defaults synchronize];\n"
		end
		def impSetter(key, value)
			"#{setter(key, value)} \{\n#{in_imp_setter(key, value)}\}\n"
		end
		def struct(key)
			"    static let #{key} = \"#{key}\""
		end
		def swift_getter(key, value)
			"func #{key}() -> #{value.swift_type_name}"
		end
		def swift_setter(key, value)
			"func set#{capitalize(key)}(#{key}: #{value.swift_type_name})"
		end
		def exchange(arrStr)
			Objective.new().parse(arrStr)
		end
	end

	class Type
		def initialize()
		end
		def == (type)
			true
		end
		def type_name
			"Type"
		end
		def swift_type_name
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
		def swift_type_name
			"AnyObject"
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
		def swift_type_name
			"String"
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
		def swift_type_name
			"NSNumber"
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
		def swift_type_name
			"NSArray"
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
		def swift_type_name
			"NSDictionary"
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
		def swift_type_name
			"NSData"
		end
	end
	class NSDate < NSObject
		def == (type)
			NSDate === type && super(type)
		end
		def type_name
			"NSDate *"
		end
		def swift_type_name
			"NSDate"
		end
		def defaultValue
			"[NSDate date]"
		end
	end
	class AnyObject < NSObject
		attr :type
		def initialize(type)
			@type = type
		end
		def == (type)
			AnyObject === type && @type === type.type && super(type)
		end
		def type_name
			"#{@type} *"
		end
		def swift_type_name
			@type
		end
	end
	class NSValue < Type
		def == (type)
			NSValue === type && super(type)
		end
		def type_name
			"NSValue"
		end
		def swift_type_name
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
		def swift_type_name
			"Int"
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
		def swift_type_name
			"Bool"
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
		def swift_type_name
			"Float"
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
		def swift_type_name
			"Double"
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
