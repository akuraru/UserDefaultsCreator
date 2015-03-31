
module Udgenerator
	class Swift
		def parse(arrStr)
			result = {}
			arrStr.each{|s|
				if /\s*(\w+) *\* *(\w+)\s*;\s*/ =~ s then
					result[$2] = object($1)
				elsif /- \((\w+) *\* *\)(\w+);/ =~ s then
					result[$2] = object($1)
				elsif /\s*func\s+(\w+)\(\s*\)\s*->\s*(\w+)\s*\{?\s*/ =~ s then 
					result[$1] = object($2)
				elsif /\s*(var|let)\s+(\w+)\s*:\s*(\w+)\??\s*;?\s*/ =~ s then 
					result[$2] = object($3)
				end
			}
			result.delete("sharedManager")
			result.delete("defaults")
			result
		end
		def object(type)
			if "NSString" == type
				NSString.new()
			elsif "String" == type
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
			elsif "Bool" == type
				NSBOOL.new()
			elsif "Int" == type
				NSInteger.new()
			elsif "Double" == type
				NSDouble.new()
			elsif "Float" == type
				NSFloat.new()
			else
				AnyObject.new("#{type}")
			end
		end
	end
end
