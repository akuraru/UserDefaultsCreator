require "udgenerator/version"
require "udgenerator/type"
require "udgenerator/objective"
require "udgenerator/swift"

module Udgenerator
	class Core
		def generator(options)
			FileUtils.mkdir_p(options[:output]) unless FileTest.exist?(options[:output])

			if options[:swift] then
				arrType = exchange(self.fileRead(options[:input]))
				File.open("#{options[:output]}#{options[:file_name]}.h", "w:UTF-8").write header(arrType, options[:file_name], options[:auto_init])
				File.open("#{options[:output]}#{options[:file_name]}.m", "w:UTF-8").write method(arrType, options[:file_name], options[:auto_init])
			else
				arrType = swift_exchange(self.fileRead(options[:input]))
				File.open("#{options[:output]}#{options[:file_name]}.swift", "w:UTF-8").write swift(arrType, options[:file_name], options[:auto_init])
			end
		end
		def initialize
		end

		def fileRead(fileName)
			File.open(fileName, :encoding => Encoding::UTF_8).read.scan(/(.*)\n/).flatten
		end
		def registHeader(register)
			if (register)
				""
			else
				"- (void)registerDefaults:(NSDictionary *)dict;\n"
			end
		end
		def header(arrType, fileName, register)
			result = ""
			arrType.each_pair{|k, v| result += interface(k, v) + "\n"}
			"\n\#import <Foundation/Foundation.h>\n\n" +
				imp_defines(arrType) +
				"\n\@interface #{fileName} : NSObject\n\n+ (instancetype)sharedManager;\n#{self.registHeader(register)}\n" + result +
				"\@end\n"
		end
		def registerDefaults(arrType)
			result = ""
			arrType.each_pair{|k, v|
				d = register_default(k, v)
				result += " "*12 + d + ",\n" if d != ""
			}
			"        [defaults registerDefaults:@{\n" + result + "        }];\n"
		end
		def init(arrType, register)
			if (register)
				"- (id)init {\n    self = [super init];\n    if (self != nil) {\n        defaults = [NSUserDefaults standardUserDefaults];\n#{registerDefaults(arrType)}    }\n\n    return self;\n}\n"
			else
				"- (id)init {\n    self = [super init];\n    if (self != nil) {\n        defaults = [NSUserDefaults standardUserDefaults];\n    }\n\n    return self;\n}\n- (void)registerDefaults:(NSDictionary *)dict {\n    [defaults registerDefaults:dict];\n}\n"
			end
		end
		def imp_defines(arrType)
			result = ""
			arrType.each_pair{|s, d| result += imp_define(s, d)}
			result
		end
		def implementation(arrType)
			result = ""
			arrType.each_pair{|s, d| result += impGetter(s, d) + impSetter(s, d) + "\n"}
			result
		end
		def method(arrType, fileName, register)
			"\#import \"#{fileName}.h\"\n\n" +
				"\@implementation #{fileName} {\n    NSUserDefaults *defaults;\n}\n\n+ (instancetype)sharedManager {\n    static #{fileName} *sharedManager_ = nil;\n    static dispatch_once_t onceToken;\n    dispatch_once(&onceToken, ^{\n        sharedManager_ = #{fileName}.new;\n    });\n\n    return sharedManager_;\n}\n\n" +
				self.init(arrType, register) + "\n" +
				self.implementation(arrType) +
				"@end\n"
		end
		def swift(arrType, fileName, register)
			"import Foundation\n\nstruct #{fileName}Register {\n#{structs(arrType)}}\n\nclass #{fileName} {" + '
    class func sharedManager() -> UserDefaults {
        struct Static {
            static let instance = UserDefaults()
        }
        return Static.instance
    }
    init() {
' + swift_register_defaults(arrType, fileName, register) + '
    }
    func defaults() -> NSUserDefaults {
        return NSUserDefaults.standardUserDefaults()
    }
    func set(value: AnyObject?, forKey: String) {
        defaults().setObject(value, forKey: forKey)
        defaults().synchronize()
    }
    func get(key: String) -> AnyObject? {
        return defaults().objectForKey(key)
    }
' + swift_get_sets(arrType, fileName) + "}\n"
		end
		def swift_register_defaults(arrType, fileName, register)
			if register then
				"        defaults().registerDefaults([\n" + registers(arrType, fileName) + "        ])"
			else
				"    }\n    func registerDefaults(dict: [String: AnyObject]) {\n        defaults().registerDefaults(dict)"
			end
		end
		def registers(arrType, fileName)
			result = ""
			arrType.each_pair{|k, v| result += swift_register_default(k, v, fileName)}
			result
		end
		def structs(arrType)
			result = ""
			arrType.each_pair{|s, d| result += struct(s) + "\n"}
			result
		end
		def swift_get_sets(arrType, fileName)
			result = ""
			arrType.each_pair{|s, d| result += "\n    #{swift_getter(s, d)} {\n        return get(#{fileName}Register.#{s}) as #{d.swift_type_name}\n    }\n    #{swift_setter(s, d)} {\n        set(#{s}, forKey: #{fileName}Register.#{s})\n    }\n"}
			result
		end
	end
end
