$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'udgenerator'


module Udgenerator
	def self.c
		[
			{string: 'String',      text: "NSString *hogeHoge;", exchange: Udgenerator::NSString.new("hogeHoge"), capitalize: "HogeHoge", define: "kHogeHoge", to_nsstring: "@\"hogeHoge\"", type_name: "NSString *",     interface_getter: "- (NSString *)hogeHoge;\n", interface_setter: "- (void)setHogeHoge:(NSString *)hogeHoge;\n", imp_define: "\#define kHogeHoge @\"hogeHoge\"\n", register_default: "kHogeHoge : @\"\"",    imp_get_message: "objectForKey",  imp_set_message: "setObject",},
			{string: 'Data',        text: "NSData *ddd;",        exchange: Udgenerator::NSData.new("ddd"),        capitalize: "Ddd",      define: "kDdd",      to_nsstring: "@\"ddd\"",      type_name: "NSData *",       interface_getter: "- (NSData *)ddd;\n",        interface_setter: "- (void)setDdd:(NSData *)ddd;\n",             imp_define: "\#define kDdd @\"ddd\"\n",           register_default: "",                     imp_get_message: "objectForKey",  imp_set_message: "setObject",},
			{string: 'Int',         text: "NSInteger i;",        exchange: Udgenerator::NSInteger.new("i"),       capitalize: "I",        define: "kI",        to_nsstring: "@\"i\"",        type_name: "NSInteger",      interface_getter: "- (NSInteger)i;\n",         interface_setter: "- (void)setI:(NSInteger)i;\n",                imp_define: "\#define kI @\"i\"\n",               register_default: "kI : @0",              imp_get_message: "integerForKey", imp_set_message: "setInteger",},
			{string: "BOOL",        text: "BOOL b;",             exchange: Udgenerator::NSBOOL.new("b"),          capitalize: "B",        define: "kB",        to_nsstring: "@\"b\"",        type_name: "BOOL",           interface_getter: "- (BOOL)b;\n",              interface_setter: "- (void)setB:(BOOL)b;\n",                     imp_define: "\#define kB @\"b\"\n",               register_default: "kB : @0",              imp_get_message: "boolForKey",    imp_set_message: "setBool",},
			{string: 'float',       text: "float f;",            exchange: Udgenerator::NSFloat.new("f"),         capitalize: "F",        define: "kF",        to_nsstring: "@\"f\"",        type_name: "float",          interface_getter: "- (float)f;\n",             interface_setter: "- (void)setF:(float)f;\n",                    imp_define: "\#define kF @\"f\"\n",               register_default: "kF : @0",              imp_get_message: "floatForKey",   imp_set_message: "setFloat",},
			{string: 'Double',      text: "double d;",           exchange: Udgenerator::NSDouble.new("d"),        capitalize: "D",        define: "kD",        to_nsstring: "@\"d\"",        type_name: "double",         interface_getter: "- (double)d;\n",            interface_setter: "- (void)setD:(double)d;\n",                   imp_define: "\#define kD @\"d\"\n",               register_default: "kD : @0",              imp_get_message: "doubleForKey",  imp_set_message: "setDouble",},
			{string: 'Array',       text: "NSArray* ary;",       exchange: Udgenerator::NSArray.new("ary"),       capitalize: "Ary",      define: "kAry",      to_nsstring: "@\"ary\"",      type_name: "NSArray *",      interface_getter: "- (NSArray *)ary;\n",       interface_setter: "- (void)setAry:(NSArray *)ary;\n",            imp_define: "\#define kAry @\"ary\"\n",           register_default: "kAry : @[]",           imp_get_message: "objectForKey",  imp_set_message: "setObject",},
			{string: 'Dictionary',  text: "NSDictionary* dic;",  exchange: Udgenerator::NSDictionary.new("dic"),  capitalize: "Dic",      define: "kDic",      to_nsstring: "@\"dic\"",      type_name: "NSDictionary *", interface_getter: "- (NSDictionary *)dic;\n",  interface_setter: "- (void)setDic:(NSDictionary *)dic;\n",       imp_define: "\#define kDic @\"dic\"\n",           register_default: "kDic : @{}",           imp_get_message: "objectForKey",  imp_set_message: "setObject",},
			{string: 'Date',        text: "NSDate * day;",       exchange: Udgenerator::NSDate.new("day"),        capitalize: "Day",      define: "kDay",      to_nsstring: "@\"day\"",      type_name: "NSDate *",       interface_getter: "- (NSDate *)day;\n",        interface_setter: "- (void)setDay:(NSDate *)day;\n",             imp_define: "\#define kDay @\"day\"\n",           register_default: "kDay : [NSDate date]", imp_get_message: "objectForKey",  imp_set_message: "setObject",},
		]
	end
end
