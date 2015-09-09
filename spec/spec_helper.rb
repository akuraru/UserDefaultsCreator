$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'udgenerator'


module Udgenerator
	def self.c
		[
			{string: 'String',      swift_text: "let hogeHoge: String",   text: "NSString *hogeHoge;", key: "hogeHoge", exchange: {"hogeHoge" => Udgenerator::NSString.new()},               capitalize: "HogeHoge", define: "kHogeHoge", to_nsstring: "@\"hogeHoge\"", type_name: "NSString *",     interface_getter: "- (NSString *)hogeHoge;\n", interface_setter: "- (void)setHogeHoge:(NSString *)hogeHoge;\n", imp_define: "\#define kHogeHoge @\"hogeHoge\"\n", register_default: "kHogeHoge : @\"\"",    swift_default_value: '""',       swift_register_defaults: " "*12+'.hogeHoge: "",'+"\n",  imp_get_message: "objectForKey",  imp_set_message: "setObject",  struct: '    case hogeHoge = "hogeHoge"', swift_getter: 'func hogeHoge() -> String',  swift_setter: "func setHogeHoge(hogeHoge: String)" },
			{string: 'Data',        swift_text: "var ddd: NSData",        text: "NSData *ddd;",        key: "ddd",      exchange: {"ddd"      => Udgenerator::NSData.new()},                 capitalize: "Ddd",      define: "kDdd",      to_nsstring: "@\"ddd\"",      type_name: "NSData *",       interface_getter: "- (NSData *)ddd;\n",        interface_setter: "- (void)setDdd:(NSData *)ddd;\n",             imp_define: "\#define kDdd @\"ddd\"\n",           register_default: "",                     swift_default_value: '',         swift_register_defaults: '',                                    imp_get_message: "objectForKey",  imp_set_message: "setObject",  struct: '    case ddd = "ddd"',           swift_getter: 'func ddd() -> NSData',       swift_setter: "func setDdd(ddd: NSData)"           },
			{string: 'Int',         swift_text: "    func i() -> Int",    text: "NSInteger i;",        key: "i",        exchange: {"i"        => Udgenerator::NSInteger.new()},              capitalize: "I",        define: "kI",        to_nsstring: "@\"i\"",        type_name: "NSInteger",      interface_getter: "- (NSInteger)i;\n",         interface_setter: "- (void)setI:(NSInteger)i;\n",                imp_define: "\#define kI @\"i\"\n",               register_default: "kI : @0",              swift_default_value: '0',        swift_register_defaults: " "*12+'.i: 0,'+"\n",          imp_get_message: "integerForKey", imp_set_message: "setInteger", struct: '    case i = "i"',               swift_getter: 'func i() -> Int',            swift_setter: "func setI(i: Int)"                  },
			{string: "BOOL",        swift_text: "    func b() -> Bool {", text: "BOOL b;",             key: "b",        exchange: {"b"        => Udgenerator::NSBOOL.new()},                 capitalize: "B",        define: "kB",        to_nsstring: "@\"b\"",        type_name: "BOOL",           interface_getter: "- (BOOL)b;\n",              interface_setter: "- (void)setB:(BOOL)b;\n",                     imp_define: "\#define kB @\"b\"\n",               register_default: "kB : @0",              swift_default_value: 'false',    swift_register_defaults: " "*12+'.b: false,'+"\n",      imp_get_message: "boolForKey",    imp_set_message: "setBool",    struct: '    case b = "b"',               swift_getter: 'func b() -> Bool',           swift_setter: "func setB(b: Bool)"                 },
			{string: 'float',       swift_text: "let f: Float",           text: "float f;",            key: "f",        exchange: {"f"        => Udgenerator::NSFloat.new()},                capitalize: "F",        define: "kF",        to_nsstring: "@\"f\"",        type_name: "float",          interface_getter: "- (float)f;\n",             interface_setter: "- (void)setF:(float)f;\n",                    imp_define: "\#define kF @\"f\"\n",               register_default: "kF : @0",              swift_default_value: '0',        swift_register_defaults: " "*12+'.f: 0,'+"\n",          imp_get_message: "floatForKey",   imp_set_message: "setFloat",   struct: '    case f = "f"',               swift_getter: 'func f() -> Float',          swift_setter: "func setF(f: Float)"                },
			{string: 'Double',      swift_text: "let d: Double",          text: "double d;",           key: "d",        exchange: {"d"        => Udgenerator::NSDouble.new()},               capitalize: "D",        define: "kD",        to_nsstring: "@\"d\"",        type_name: "double",         interface_getter: "- (double)d;\n",            interface_setter: "- (void)setD:(double)d;\n",                   imp_define: "\#define kD @\"d\"\n",               register_default: "kD : @0",              swift_default_value: '0',        swift_register_defaults: " "*12+'.d: 0,'+"\n",          imp_get_message: "doubleForKey",  imp_set_message: "setDouble",  struct: '    case d = "d"',               swift_getter: 'func d() -> Double',         swift_setter: "func setD(d: Double)"               },
			{string: 'Array',       swift_text: "let ary: NSArray",       text: "NSArray* ary;",       key: "ary",      exchange: {"ary"      => Udgenerator::NSArray.new()},                capitalize: "Ary",      define: "kAry",      to_nsstring: "@\"ary\"",      type_name: "NSArray *",      interface_getter: "- (NSArray *)ary;\n",       interface_setter: "- (void)setAry:(NSArray *)ary;\n",            imp_define: "\#define kAry @\"ary\"\n",           register_default: "kAry : @[]",           swift_default_value: '',         swift_register_defaults: '',                                    imp_get_message: "objectForKey",  imp_set_message: "setObject",  struct: '    case ary = "ary"',           swift_getter: 'func ary() -> NSArray',      swift_setter: "func setAry(ary: NSArray)"          },
			{string: 'Dictionary',  swift_text: "let dic: NSDictionary",  text: "NSDictionary* dic;",  key: "dic",      exchange: {"dic"      => Udgenerator::NSDictionary.new()},           capitalize: "Dic",      define: "kDic",      to_nsstring: "@\"dic\"",      type_name: "NSDictionary *", interface_getter: "- (NSDictionary *)dic;\n",  interface_setter: "- (void)setDic:(NSDictionary *)dic;\n",       imp_define: "\#define kDic @\"dic\"\n",           register_default: "kDic : @{}",           swift_default_value: '',         swift_register_defaults: '',                                    imp_get_message: "objectForKey",  imp_set_message: "setObject",  struct: '    case dic = "dic"',           swift_getter: 'func dic() -> NSDictionary', swift_setter: "func setDic(dic: NSDictionary)"     },
			{string: 'Date',        swift_text: "let day: NSDate",        text: "NSDate * day;",       key: "day",      exchange: {"day"      => Udgenerator::NSDate.new()},                 capitalize: "Day",      define: "kDay",      to_nsstring: "@\"day\"",      type_name: "NSDate *",       interface_getter: "- (NSDate *)day;\n",        interface_setter: "- (void)setDay:(NSDate *)day;\n",             imp_define: "\#define kDay @\"day\"\n",           register_default: "kDay : [NSDate date]", swift_default_value: 'NSDate()', swift_register_defaults: " "*12+'.day: NSDate(),'+"\n", imp_get_message: "objectForKey",  imp_set_message: "setObject",  struct: '    case day = "day"',           swift_getter: 'func day() -> NSDate',       swift_setter: "func setDay(day: NSDate)"           },
			{string: 'Object',      swift_text: "let url: NSURL",         text: "NSURL * url;",        key: "url",      exchange: {"url"      => Udgenerator::NSURL.new()},                  capitalize: "Url",      define: "kUrl",      to_nsstring: "@\"url\"",      type_name: "NSURL *",        interface_getter: "- (NSURL *)url;\n",         interface_setter: "- (void)setUrl:(NSURL *)url;\n",              imp_define: "\#define kUrl @\"url\"\n",           register_default: "",                     swift_default_value: '',         swift_register_defaults: '',                                    imp_get_message: "objectForKey",  imp_set_message: "setObject",  struct: '    case url = "url"',           swift_getter: 'func url() -> NSURL',        swift_setter: "func setUrl(url: NSURL)"            },
		]
	end
end
