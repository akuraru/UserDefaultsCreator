
module Udgenerator
	class Objective
		def parse(arrStr)
			result = {}
			arrStr.each{|s|
				if /\s*(\w+) *\* *(\w+)\s*;\s*/ =~ s then
					result[$2] = object($1, $2)
				elsif /- \((\w+) *\* *\)(\w+);/ =~ s then
					result[$2] = object($1, $2)
				elsif /\s*(\w+)\s+(\w+)\s*;\s*/ =~ s then
					result[$2] = value($1, $2)
				elsif /- \((\w+)\)(\w+);/ =~ s then
					result[$2] = value($1, $2)
				end
			}
			result
		end
		def object(type, name)
			if "NSString" == type
				NSString.new(name)
			elsif "NSNumber" == type
				NSNumber.new(name)
			elsif "NSArray" == type
				NSArray.new(name)
			elsif "NSDictionary" == type
				NSDictionary.new(name)
			elsif "NSData" == type
				NSData.new(name)
			elsif "NSDate" == type
				NSDate.new(name)
			else
				NSObject.new(name)
			end
		end
		def value(type, name)
			if "NSInteger" == type then
				NSInteger.new(name)
			elsif "BOOL" == type then
				NSBOOL.new(name)
			elsif "float" == type then
				NSFloat.new(name)
			elsif "double" == type then
				NSDouble.new(name)
			else
				NSObject.new(name)
			end
		end
	end
end
