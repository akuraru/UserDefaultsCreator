require "udgenerator/version"
require "udgenerator/type"
require "udgenerator/objective"
require "udgenerator/swift"

module Udgenerator
	class Core
		def generator(options)
			FileUtils.mkdir_p(options[:output]) unless FileTest.exist?(options[:output])

			if options[:swift] then
				arrType = swift_exchange(self.fileRead(options[:input]))
				File.open("#{options[:output]}#{options[:file_name]}.swift", "w:UTF-8").write swift(arrType, options[:file_name], options[:auto_init])
			else
				arrType = exchange(self.fileRead(options[:input]))
				File.open("#{options[:output]}#{options[:file_name]}.h", "w:UTF-8").write header(arrType, options[:file_name], options[:auto_init])
				File.open("#{options[:output]}#{options[:file_name]}.m", "w:UTF-8").write method(arrType, options[:file_name], options[:auto_init])
			end
		end
		def initialize
		end

		def fileRead(fileName)
			if (File.exist?(fileName)) then
				File.open(fileName, :encoding => Encoding::UTF_8).read.scan(/(.*)\n/).flatten
			else
				[]
			end
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
			"\#import <Foundation/Foundation.h>\n\n" +
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
			"import Foundation\n\nenum #{fileName}Register: String {\n#{structs(arrType)}}\n\nclass #{fileName} {" + '
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
    func set(value: AnyObject?, forKey key: UserDefaultsRegister) {
        defaults().setObject(value, forKey: key.rawValue)
        defaults().synchronize()
    }
    func get(key: UserDefaultsRegister) -> AnyObject? {
        return defaults().objectForKey(key.rawValue)
    }
' + swift_get_sets(arrType, fileName) + "}\n"
		end
		def swift_register_defaults(arrType, fileName, register)
			defaults = if register then
				"        registerDefaults(" + registers(arrType, fileName) + ")\n"
			else
				""
			end
			defaults + "    }\n    func registerDefaults(dict: [#{fileName}Register: AnyObject]) {\n        var register: [String: AnyObject] = [:]\n        for (key, value) in dict {\n            register[key.rawValue] = value\n        }\n        defaults().registerDefaults(register)"
		end
		def registers(arrType, fileName)
			if (arrType.count == 0) then
				"[:]"
			else
				result = ""
				arrType.each_pair{|k, v| result += swift_register_default(k, v, fileName)}
				"[\n#{result}        ]"
			end
		end
		def structs(arrType)
			result = ""
			arrType.each_pair{|s, d| result += struct(s) + "\n"}
			result
		end
		def swift_get_sets(arrType, fileName)
			result = ""
			arrType.each_pair{|s, d| result += "\n    var #{s}: #{d.swift_type_name} {\n        get {\n            return get(.#{s}) as! #{d.swift_type_name}\n        } set(newValue) {\n            set(newValue, forKey: .#{s})\n        }\n    }\n"}
			result
		end
	end
end
