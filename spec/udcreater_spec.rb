require 'spec_helper'

describe Udcreater do
  it 'has a version number' do
    expect(Udcreater::VERSION).not_to be "1.0.0"
  end

  before(:all) {
    @creater = Udcreater::Core.new
  }
  c = [
    {string: 'String', text: "NSString *hogeHoge;", exchange: Udcreater::NSString.new("hogeHoge"), capitalize: "HogeHoge", define: "kHogeHoge", to_nsstring: "@\"hogeHoge\"", type_name: "NSString *", interface_getter: "- (NSString *)hogeHoge;\n", interface_setter: "- (void)setHogeHoge:(NSString *)hogeHoge;\n", imp_define: "\#define kHogeHoge @\"hogeHoge\"\n", register_default: "kHogeHoge : @\"\"", imp_get_message: "objectForKey",  imp_set_message: "setObject",},
    {string: 'Data',   text: "NSData *ddd;",        exchange: Udcreater::NSData.new("ddd"),        capitalize: "Ddd",      define: "kDdd",      to_nsstring: "@\"ddd\"",      type_name: "NSData *",   interface_getter: "- (NSData *)ddd;\n",        interface_setter: "- (void)setDdd:(NSData *)ddd;\n",             imp_define: "\#define kDdd @\"ddd\"\n",           register_default: "",                  imp_get_message: "objectForKey",  imp_set_message: "setObject",},
    {string: 'Int',    text: "NSInteger i;",        exchange: Udcreater::NSInteger.new("i"),       capitalize: "I",        define: "kI",        to_nsstring: "@\"i\"",        type_name: "NSInteger",  interface_getter: "- (NSInteger)i;\n",         interface_setter: "- (void)setI:(NSInteger)i;\n",                imp_define: "\#define kI @\"i\"\n",               register_default: "kI : @0",           imp_get_message: "integerForKey", imp_set_message: "setInteger",},
    {string: "BOOL",   text: "BOOL b;",             exchange: Udcreater::NSBOOL.new("b"),          capitalize: "B",        define: "kB",        to_nsstring: "@\"b\"",        type_name: "BOOL",       interface_getter: "- (BOOL)b;\n",              interface_setter: "- (void)setB:(BOOL)b;\n",                     imp_define: "\#define kB @\"b\"\n",               register_default: "kB : @0",           imp_get_message: "boolForKey",    imp_set_message: "setBool",},
    {string: 'float',  text: "float f;",            exchange: Udcreater::NSFloat.new("f"),         capitalize: "F",        define: "kF",        to_nsstring: "@\"f\"",        type_name: "float",      interface_getter: "- (float)f;\n",             interface_setter: "- (void)setF:(float)f;\n",                    imp_define: "\#define kF @\"f\"\n",               register_default: "kF : @0",           imp_get_message: "floatForKey",   imp_set_message: "setFloat",},
    {string: 'Double', text: "double d;",           exchange: Udcreater::NSDouble.new("d"),        capitalize: "D",        define: "kD",        to_nsstring: "@\"d\"",        type_name: "double",     interface_getter: "- (double)d;\n",            interface_setter: "- (void)setD:(double)d;\n",                   imp_define: "\#define kD @\"d\"\n",               register_default: "kD : @0",           imp_get_message: "doubleForKey",  imp_set_message: "setDouble",},
  ]
  context 'Type' do
    c.each { |d|
      context d[:string] do
        before(:each) {
          @exchange = @creater.exchange([d[:text]])[0]
        }
        it :expect do
          expect(@exchange).to eq d[:exchange]
        end
        it :capitalize do
          expect(@exchange.capitalize).to eq d[:capitalize]
        end
        it :define do
          expect(@exchange.define).to eq d[:define]
        end
        it :to_nsstring do
          expect(@exchange.to_nsstring).to eq d[:to_nsstring]
        end
        it :type_name do
          expect(@exchange.type_name).to eq d[:type_name]
        end
        it :interface_getter do
          expect(@exchange.interface_getter).to eq d[:interface_getter]
        end
        it :interface_setter do
          expect(@exchange.interface_setter).to eq d[:interface_setter]
        end
        it :imp_define do
          expect(@exchange.imp_define).to eq d[:imp_define]
        end
        it :register_default do
          expect(@exchange.register_default).to eq d[:register_default]
        end
        it :imp_get_message do
          expect(@exchange.imp_get_message).to eq d[:imp_get_message]
        end
        it :imp_set_message do
          expect(@exchange.imp_set_message).to eq d[:imp_set_message]
        end
      end
    }
  end
  context 'userdefaults' do
    it 'does something useful' do
      text = @creater.fileRead('file/Base.h')
      ex = [
        "NSString *itIsLongName;",
        "NSNumber *number;",
        "NSArray *array;",
        "NSDictionary *dict;",
        "NSData *data;",
        "NSDate *date;",
        "NSInteger i;",
        "BOOL b;",
        "float f;",
        "double d;",
      ]
      expect(text).to eq ex
    end
    exchange = c.map{|d| d[:exchange]}
    context 'header' do
      it 'true' do
        expect(@creater.header(exchange, "UserDefaults", true)).to eq '
#import <Foundation/Foundation.h>

#define kHogeHoge @"hogeHoge"
#define kDdd @"ddd"
#define kI @"i"
#define kB @"b"
#define kF @"f"
#define kD @"d"

@interface UserDefaults : NSObject

+ (instancetype)sharedManager;

- (NSString *)hogeHoge;
- (void)setHogeHoge:(NSString *)hogeHoge;

- (NSData *)ddd;
- (void)setDdd:(NSData *)ddd;

- (NSInteger)i;
- (void)setI:(NSInteger)i;

- (BOOL)b;
- (void)setB:(BOOL)b;

- (float)f;
- (void)setF:(float)f;

- (double)d;
- (void)setD:(double)d;

@end
'
      end
      it 'false' do
        expect(@creater.header(exchange, "UserDefaults", false)).to eq '
#import <Foundation/Foundation.h>

#define kHogeHoge @"hogeHoge"
#define kDdd @"ddd"
#define kI @"i"
#define kB @"b"
#define kF @"f"
#define kD @"d"

@interface UserDefaults : NSObject

+ (instancetype)sharedManager;
- (void)registerDefaults:(NSDictionary *)dict;

- (NSString *)hogeHoge;
- (void)setHogeHoge:(NSString *)hogeHoge;

- (NSData *)ddd;
- (void)setDdd:(NSData *)ddd;

- (NSInteger)i;
- (void)setI:(NSInteger)i;

- (BOOL)b;
- (void)setB:(BOOL)b;

- (float)f;
- (void)setF:(float)f;

- (double)d;
- (void)setD:(double)d;

@end
'
      end
    end
    context 'method' do
      it 'true' do
        expect(@creater.method(exchange, "UserDefaults", true)).to eq '#import "UserDefaults.h"

@implementation UserDefaults {
    NSUserDefaults *defaults;
}

+ (instancetype)sharedManager {
    static UserDefaults *sharedManager_ = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager_ = UserDefaults.new;
    });

    return sharedManager_;
}

- (id)init {
    self = [super init];
    if (self != nil) {
        defaults = [NSUserDefaults standardUserDefaults];
        [defaults registerDefaults:@{
            kHogeHoge : @"",
            kI : @0,
            kB : @0,
            kF : @0,
            kD : @0,
        }];
    }

    return self;
}

- (NSString *)hogeHoge {
    return [defaults objectForKey:kHogeHoge];
}
- (void)setHogeHoge:(NSString *)hogeHoge {
    [defaults setObject:hogeHoge forKey:kHogeHoge];
    [defaults synchronize];
}

- (NSData *)ddd {
    return [defaults objectForKey:kDdd];
}
- (void)setDdd:(NSData *)ddd {
    [defaults setObject:ddd forKey:kDdd];
    [defaults synchronize];
}

- (NSInteger)i {
    return [defaults integerForKey:kI];
}
- (void)setI:(NSInteger)i {
    [defaults setInteger:i forKey:kI];
    [defaults synchronize];
}

- (BOOL)b {
    return [defaults boolForKey:kB];
}
- (void)setB:(BOOL)b {
    [defaults setBool:b forKey:kB];
    [defaults synchronize];
}

- (float)f {
    return [defaults floatForKey:kF];
}
- (void)setF:(float)f {
    [defaults setFloat:f forKey:kF];
    [defaults synchronize];
}

- (double)d {
    return [defaults doubleForKey:kD];
}
- (void)setD:(double)d {
    [defaults setDouble:d forKey:kD];
    [defaults synchronize];
}

@end
'
      end
      it 'false' do
        expect(@creater.method(exchange, "UserDefaults", false)).to eq '#import "UserDefaults.h"

@implementation UserDefaults {
    NSUserDefaults *defaults;
}

+ (instancetype)sharedManager {
    static UserDefaults *sharedManager_ = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager_ = UserDefaults.new;
    });

    return sharedManager_;
}

- (id)init {
    self = [super init];
    if (self != nil) {
        defaults = [NSUserDefaults standardUserDefaults];
    }

    return self;
}
- (void)registerDefaults:(NSDictionary *)dict {
    [defaults registerDefaults:dict];
}

- (NSString *)hogeHoge {
    return [defaults objectForKey:kHogeHoge];
}
- (void)setHogeHoge:(NSString *)hogeHoge {
    [defaults setObject:hogeHoge forKey:kHogeHoge];
    [defaults synchronize];
}

- (NSData *)ddd {
    return [defaults objectForKey:kDdd];
}
- (void)setDdd:(NSData *)ddd {
    [defaults setObject:ddd forKey:kDdd];
    [defaults synchronize];
}

- (NSInteger)i {
    return [defaults integerForKey:kI];
}
- (void)setI:(NSInteger)i {
    [defaults setInteger:i forKey:kI];
    [defaults synchronize];
}

- (BOOL)b {
    return [defaults boolForKey:kB];
}
- (void)setB:(BOOL)b {
    [defaults setBool:b forKey:kB];
    [defaults synchronize];
}

- (float)f {
    return [defaults floatForKey:kF];
}
- (void)setF:(float)f {
    [defaults setFloat:f forKey:kF];
    [defaults synchronize];
}

- (double)d {
    return [defaults doubleForKey:kD];
}
- (void)setD:(double)d {
    [defaults setDouble:d forKey:kD];
    [defaults synchronize];
}

@end
'
      end
    end
  end
end
