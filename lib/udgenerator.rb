require "udgenerator/version"
require "udgenerator/type"
require "udgenerator/objective"

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
		def capitalize(str)
			c = str
			c[0,1].capitalize + c[1..-1]
		end
		def define(str)
			"k" + capitalize(str)
		end
		def to_nsstring(str)
			'@"' + str + '"'
		end
		def exchange(arrStr)
			Objective.new().parse(arrStr)
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
			"\n\#import <Foundation/Foundation.h>\n\n" +
				self.define(arrType) +
				"\n\@interface #{fileName} : NSObject\n\n+ (instancetype)sharedManager;\n#{self.registHeader(register)}\n" +
				arrType.map{|s| s.interface + "\n"}.inject(""){|s, i| s + i} +
				"\@end\n"
		end
		def registerDefaults(arrType)
			"        [defaults registerDefaults:@{\n" +
				arrType.map{|s| s.register_default}.select{|s| s != ""}.map{|s| " "*12 + s + ",\n"}.inject(""){|s, i| s + i} +
				"        }];\n"
		end
		def init(arrType, register)
			if (register)
				"- (id)init {\n    self = [super init];\n    if (self != nil) {\n        defaults = [NSUserDefaults standardUserDefaults];\n#{self.registerDefaults(arrType)}    }\n\n    return self;\n}\n"
			else
				"- (id)init {\n    self = [super init];\n    if (self != nil) {\n        defaults = [NSUserDefaults standardUserDefaults];\n    }\n\n    return self;\n}\n- (void)registerDefaults:(NSDictionary *)dict {\n    [defaults registerDefaults:dict];\n}\n"
			end
		end
		def define(arrType)
			arrType.map{|s| s.imp_define}.inject(""){|s, i| s + i}
		end
		def implementation(arrType)
			arrType.map{|s| s.impGetter + s.impSetter + "\n"}.inject(""){|s, i| s + i}
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
