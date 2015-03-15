require "udgenerator/version"
require "udgenerator/type"
require "udgenerator/objective"
require "udgenerator/swift"

module Udgenerator
	class Core
		def generator(options)
			arrType = self.exchange(self.fileRead(file))

			FileUtils.mkdir_p(dir) unless FileTest.exist?(dir)
			File.open("#{dir}#{$fileName}.h", "w:UTF-8").write self.header(arrType, $fileName)
			File.open("#{dir}#{$fileName}.m", "w:UTF-8").write self.method(arrType, $fileName)
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
	end
end
