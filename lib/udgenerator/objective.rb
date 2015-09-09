
module Udgenerator
	class Objective
		def parse(arrStr)
			result = {}
			arrStr.each{|s|
				if /\s*(\w+) *\* *(\w+)\s*;\s*/ =~ s then
					result[$2] = object($1)
				elsif /- \((\w+) *\* *\)(\w+);/ =~ s then
					result[$2] = object($1)
				elsif /\s*(\w+)\s+(\w+)\s*;\s*/ =~ s then
					result[$2] = value($1)
				elsif /- \((\w+)\)(\w+);/ =~ s then
					result[$2] = value($1)
				end
			}
			result
		end
		def object(type)
			if "NSString" == type
				NSString.new()
			elsif "NSNumber" == type
				NSNumber.new()
			elsif "NSArray" == type
				NSArray.new()
			elsif "NSDictionary" == type
				NSDictionary.new()
			elsif "NSData" == type
				NSData.new()
			elsif "NSDate" == type
				NSDate.new()
			elsif "NSURL" == type
				NSURL.new()
			else
				AnyObject.new("#{type}")
			end
		end
		def value(type)
			if "NSInteger" == type then
				NSInteger.new()
			elsif "BOOL" == type then
				NSBOOL.new()
			elsif "float" == type then
				NSFloat.new()
			elsif "double" == type then
				NSDouble.new()
			else
				AnyObject.new("#{type}")
			end
		end
	end
end
