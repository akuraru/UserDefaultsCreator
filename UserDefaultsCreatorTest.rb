require 'UserDefaultsCreator'

def test (obj , result)
  if obj != result then
    puts obj
    p " is not "
    p result
  end
end

user = UserDefualts.new
str = user.fileRead('Base.h')
test(str, ["NSString *itIsLongName;",
"NSNumber *number;",
"NSArray *array;",
"NSDictionary *dict;",
"NSData *data;",
"NSDate *date;",
"NSInteger i;",
"BOOL b;",
"float f;",
"double d;",
])

exchange = user.exchange([
  "NSString *hogeHoge;",
  "NSData *ddd;",
  "NSInteger i;",
  "BOOL b;",
  "float f;",
  "",
  "double d;"
])
test(exchange, [
  NSString.new("hogeHoge"),
  NSData.new("ddd"),
  NSInteger.new("i"),
  NSBOOL.new("b"),
  NSFloat.new("f"),
  NSDouble.new("d"),
])

capital = exchange.map{|s| s.capitalize}
test(capital, [
  "HogeHoge",
  "Ddd",
  "I",
  "B",
  "F",
  "D",
])

define = exchange.map{|s| s.define}
test(define, [
  "kHogeHoge",
  "kDdd",
  "kI",
  "kB",
  "kF",
  "kD",
])

nsString = exchange.map{|s| s.nsString}
test(nsString, [
  "@\"hogeHoge\"",
  "@\"ddd\"",
  "@\"i\"",
  "@\"b\"",
  "@\"f\"",
  "@\"d\"",
])

typeName = exchange.map{|s| s.typeName}
test(typeName, [
  "NSString *",
  "NSData *",
  "NSInteger",
  "BOOL",
  "float",
  "double"
])

interfaceGetter = exchange.map{|s| s.interfaceGetter}
test(interfaceGetter, [
  "- (NSString *)hogeHoge;\n",
  "- (NSData *)ddd;\n",
  "- (NSInteger)i;\n",
  "- (BOOL)b;\n",
  "- (float)f;\n",
  "- (double)d;\n"
])

interfaceSetter = exchange.map{|s| s.interfaceSetter}
test(interfaceSetter, [
  "- (void)setHogeHoge:(NSString *)hogeHoge;\n",
  "- (void)setDdd:(NSData *)ddd;\n",
  "- (void)setI:(NSInteger)i;\n",
  "- (void)setB:(BOOL)b;\n",
  "- (void)setF:(float)f;\n",
  "- (void)setD:(double)d;\n"
])

impDefine = exchange.map{|s| s.impDefine}
test(impDefine, [
  "\#define kHogeHoge @\"hogeHoge\"\n",
  "\#define kDdd @\"ddd\"\n",
  "\#define kI @\"i\"\n",
  "\#define kB @\"b\"\n",
  "\#define kF @\"f\"\n",
  "\#define kD @\"d\"\n",
])

registerDefault = exchange.map{|s| s.registerDefault}
test(registerDefault, [
  "kHogeHoge : @\"\"",
  "",
  "kI : @0",
  "kB : @0",
  "kF : @0",
  "kD : @0",
])

impGetMessage = exchange.map{|s| s.impGetMessage}
test(impGetMessage, [
  "objectForKey",
  "objectForKey",
  "integerForKey",
  "boolForKey",
  "floatForKey",
  "doubleForKey",
])

impSetMessage = exchange.map{|s| s.impSetMessage}
test(impSetMessage, [
  "setObject",
  "setObject",
  "setInteger",
  "setBool",
  "setFloat",
  "setDouble",
])

impGetter = exchange.map{|s| s.impGetter}
test(impGetter, [
  '- (NSString *)hogeHoge {
    return [defaults objectForKey:kHogeHoge];
}
',
  '- (NSData *)ddd {
    return [defaults objectForKey:kDdd];
}
',
  '- (NSInteger)i {
    return [defaults integerForKey:kI];
}
',
  '- (BOOL)b {
    return [defaults boolForKey:kB];
}
',
  '- (float)f {
    return [defaults floatForKey:kF];
}
',
  '- (double)d {
    return [defaults doubleForKey:kD];
}
',
])

impSetter = exchange.map{|s| s.impSetter}
test(impSetter, [
  '- (void)setHogeHoge:(NSString *)hogeHoge {
    [defaults setObject:hogeHoge forKey:kHogeHoge];
    [defaults synchronize];
}
',
  '- (void)setDdd:(NSData *)ddd {
    [defaults setObject:ddd forKey:kDdd];
    [defaults synchronize];
}
',
  '- (void)setI:(NSInteger)i {
    [defaults setInteger:i forKey:kI];
    [defaults synchronize];
}
',
  '- (void)setB:(BOOL)b {
    [defaults setBool:b forKey:kB];
    [defaults synchronize];
}
',
  '- (void)setF:(float)f {
    [defaults setFloat:f forKey:kF];
    [defaults synchronize];
}
',
  '- (void)setD:(double)d {
    [defaults setDouble:d forKey:kD];
    [defaults synchronize];
}
',
])

property = exchange.map{|s| s.property}
test(property, [
"@property NSString * hogeHoge;\n",
"@property NSData * ddd;\n",
"@property NSInteger i;\n",
"@property BOOL b;\n",
"@property float f;\n",
"@property double d;\n"
])

interface = exchange.map{|s| s.interface}
test(interface, [
'- (NSString *)hogeHoge;
- (void)setHogeHoge:(NSString *)hogeHoge;
',
'- (NSData *)ddd;
- (void)setDdd:(NSData *)ddd;
',
'- (NSInteger)i;
- (void)setI:(NSInteger)i;
',
'- (BOOL)b;
- (void)setB:(BOOL)b;
',
'- (float)f;
- (void)setF:(float)f;
',
'- (double)d;
- (void)setD:(double)d;
',
])

header = user.header(exchange, "UserDefaults")
test(header, '
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
')

init = user.init(exchange)
test(init, '- (id)init {
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
')

define = user.define(exchange)
test(define, 
'#define kHogeHoge @"hogeHoge"
#define kDdd @"ddd"
#define kI @"i"
#define kB @"b"
#define kF @"f"
#define kD @"d"
')

implementation = user.implementation(exchange)
test(implementation,
'- (NSString *)hogeHoge {
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

')

method = user.method(exchange, "UserDefaults")
test(method,
'#import "UserDefaults.h"

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
')

$shorthand = true;
impGetter = exchange.map{|s| s.impGetter}
test(impGetter, [
  '- (NSString *)hogeHoge {
    return defaults[kHogeHoge];
}
',
  '- (NSData *)ddd {
    return defaults[kDdd];
}
',
  '- (NSInteger)i {
    return [defaults[kI] integerValue];
}
',
  '- (BOOL)b {
    return [defaults[kB] boolValue];
}
',
  '- (float)f {
    return [defaults[kF] floatValue];
}
',
  '- (double)d {
    return [defaults[kD] doubleValue];
}
',
])

impSetter = exchange.map{|s| s.impSetter}
test(impSetter, [
  '- (void)setHogeHoge:(NSString *)hogeHoge {
    defaults[kHogeHoge] = hogeHoge;
    [defaults synchronize];
}
',
  '- (void)setDdd:(NSData *)ddd {
    defaults[kDdd] = ddd;
    [defaults synchronize];
}
',
  '- (void)setI:(NSInteger)i {
    defaults[kI] = @(i);
    [defaults synchronize];
}
',
  '- (void)setB:(BOOL)b {
    defaults[kB] = @(b);
    [defaults synchronize];
}
',
  '- (void)setF:(float)f {
    defaults[kF] = @(f);
    [defaults synchronize];
}
',
  '- (void)setD:(double)d {
    defaults[kD] = @(d);
    [defaults synchronize];
}
',
])

$register = false
init = user.init(exchange)
test(init, '- (id)init {
    self = [super init];
    if (self != nil) {
        defaults = [NSUserDefaults standardUserDefaults];
    }

    return self;
}
')

exchange = user.exchange([
  "NSString *hogeHoge;",
  "NSData *ddd;",
  "NSInteger i;",
  "- (BOOL)b;",
  "    float    f   ;   ",
  "",
  "double d;"
])
test(exchange, [
  NSString.new("hogeHoge"),
  NSData.new("ddd"),
  NSInteger.new("i"),
  NSBOOL.new("b"),
  NSFloat.new("f"),
  NSDouble.new("d"),
])