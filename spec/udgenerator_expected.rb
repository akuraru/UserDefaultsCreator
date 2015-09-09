
module Udgenerator
    def self.expected
        {
            header: {
                true: {
                    exist:
                    '#import <Foundation/Foundation.h>

#define kHogeHoge @"hogeHoge"
#define kDdd @"ddd"
#define kI @"i"
#define kB @"b"
#define kF @"f"
#define kD @"d"
#define kAry @"ary"
#define kDic @"dic"
#define kDay @"day"
#define kUrl @"url"

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

- (NSArray *)ary;
- (void)setAry:(NSArray *)ary;

- (NSDictionary *)dic;
- (void)setDic:(NSDictionary *)dic;

- (NSDate *)day;
- (void)setDay:(NSDate *)day;

- (NSURL *)url;
- (void)setUrl:(NSURL *)url;

@end
', 
                    empty:
                    '#import <Foundation/Foundation.h>


@interface UserDefaults : NSObject

+ (instancetype)sharedManager;

@end
',
                },
                false: {
                    exist:
                    '#import <Foundation/Foundation.h>

#define kHogeHoge @"hogeHoge"
#define kDdd @"ddd"
#define kI @"i"
#define kB @"b"
#define kF @"f"
#define kD @"d"
#define kAry @"ary"
#define kDic @"dic"
#define kDay @"day"
#define kUrl @"url"

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

- (NSArray *)ary;
- (void)setAry:(NSArray *)ary;

- (NSDictionary *)dic;
- (void)setDic:(NSDictionary *)dic;

- (NSDate *)day;
- (void)setDay:(NSDate *)day;

- (NSURL *)url;
- (void)setUrl:(NSURL *)url;

@end
',
                    empty:
                    '#import <Foundation/Foundation.h>


@interface UserDefaults : NSObject

+ (instancetype)sharedManager;
- (void)registerDefaults:(NSDictionary *)dict;

@end
',
                },
            },
            method: {
                true: {
                    exist:
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
            kAry : @[],
            kDic : @{},
            kDay : [NSDate date],
            kUrl : [[NSURL alloc] init],
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

- (NSArray *)ary {
    return [defaults objectForKey:kAry];
}
- (void)setAry:(NSArray *)ary {
    [defaults setObject:ary forKey:kAry];
    [defaults synchronize];
}

- (NSDictionary *)dic {
    return [defaults objectForKey:kDic];
}
- (void)setDic:(NSDictionary *)dic {
    [defaults setObject:dic forKey:kDic];
    [defaults synchronize];
}

- (NSDate *)day {
    return [defaults objectForKey:kDay];
}
- (void)setDay:(NSDate *)day {
    [defaults setObject:day forKey:kDay];
    [defaults synchronize];
}

- (NSURL *)url {
    return [defaults objectForKey:kUrl];
}
- (void)setUrl:(NSURL *)url {
    [defaults setObject:url forKey:kUrl];
    [defaults synchronize];
}

@end
',
                    empty:
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
        }];
    }

    return self;
}

@end
',
                },
                false: {
                    exist:
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

- (NSArray *)ary {
    return [defaults objectForKey:kAry];
}
- (void)setAry:(NSArray *)ary {
    [defaults setObject:ary forKey:kAry];
    [defaults synchronize];
}

- (NSDictionary *)dic {
    return [defaults objectForKey:kDic];
}
- (void)setDic:(NSDictionary *)dic {
    [defaults setObject:dic forKey:kDic];
    [defaults synchronize];
}

- (NSDate *)day {
    return [defaults objectForKey:kDay];
}
- (void)setDay:(NSDate *)day {
    [defaults setObject:day forKey:kDay];
    [defaults synchronize];
}

- (NSURL *)url {
    return [defaults objectForKey:kUrl];
}
- (void)setUrl:(NSURL *)url {
    [defaults setObject:url forKey:kUrl];
    [defaults synchronize];
}

@end
',
                    empty:
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
    }

    return self;
}
- (void)registerDefaults:(NSDictionary *)dict {
    [defaults registerDefaults:dict];
}

@end
',
                },
            },
            swift: {
                true: {
                    exist:
                    'import Foundation

enum UserDefaultsRegister: String {
    case hogeHoge = "hogeHoge"
    case ddd = "ddd"
    case i = "i"
    case b = "b"
    case f = "f"
    case d = "d"
    case ary = "ary"
    case dic = "dic"
    case day = "day"
    case url = "url"
}

class UserDefaults {
    class func sharedManager() -> UserDefaults {
        struct Static {
            static let instance = UserDefaults()
        }
        return Static.instance
    }
    init() {
        registerDefaults([
            .hogeHoge: "",
            .i: 0,
            .b: false,
            .f: 0,
            .d: 0,
            .day: NSDate(),
            .url: NSURL(),
        ])
    }
    func registerDefaults(dict: [UserDefaultsRegister: AnyObject]) {
        var register: [String: AnyObject] = [:]
        for (key, value) in dict {
            register[key.rawValue] = value
        }
        defaults().registerDefaults(register)
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

    var hogeHoge: String {
        get {
            return get(.hogeHoge) as! String
        } set(newValue) {
            set(newValue, forKey: .hogeHoge)
        }
    }

    var ddd: NSData {
        get {
            return get(.ddd) as! NSData
        } set(newValue) {
            set(newValue, forKey: .ddd)
        }
    }

    var i: Int {
        get {
            return get(.i) as! Int
        } set(newValue) {
            set(newValue, forKey: .i)
        }
    }

    var b: Bool {
        get {
            return get(.b) as! Bool
        } set(newValue) {
            set(newValue, forKey: .b)
        }
    }

    var f: Float {
        get {
            return get(.f) as! Float
        } set(newValue) {
            set(newValue, forKey: .f)
        }
    }

    var d: Double {
        get {
            return get(.d) as! Double
        } set(newValue) {
            set(newValue, forKey: .d)
        }
    }

    var ary: [AnyObject] {
        get {
            return get(.ary) as! [AnyObject]
        } set(newValue) {
            set(newValue, forKey: .ary)
        }
    }

    var dic: [String:AnyObject] {
        get {
            return get(.dic) as! [String:AnyObject]
        } set(newValue) {
            set(newValue, forKey: .dic)
        }
    }

    var day: NSDate {
        get {
            return get(.day) as! NSDate
        } set(newValue) {
            set(newValue, forKey: .day)
        }
    }

    var url: NSURL {
        get {
            return get(.url) as! NSURL
        } set(newValue) {
            set(newValue, forKey: .url)
        }
    }
}
',
                    empty: 'import Foundation

enum UserDefaultsRegister: String {
}

class UserDefaults {
    class func sharedManager() -> UserDefaults {
        struct Static {
            static let instance = UserDefaults()
        }
        return Static.instance
    }
    init() {
        registerDefaults([:])
    }
    func registerDefaults(dict: [UserDefaultsRegister: AnyObject]) {
        var register: [String: AnyObject] = [:]
        for (key, value) in dict {
            register[key.rawValue] = value
        }
        defaults().registerDefaults(register)
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
}
',
                },
                false: {
                    exist:
                    'import Foundation

enum UserDefaultsRegister: String {
    case hogeHoge = "hogeHoge"
    case ddd = "ddd"
    case i = "i"
    case b = "b"
    case f = "f"
    case d = "d"
    case ary = "ary"
    case dic = "dic"
    case day = "day"
    case url = "url"
}

class UserDefaults {
    class func sharedManager() -> UserDefaults {
        struct Static {
            static let instance = UserDefaults()
        }
        return Static.instance
    }
    init() {
    }
    func registerDefaults(dict: [UserDefaultsRegister: AnyObject]) {
        var register: [String: AnyObject] = [:]
        for (key, value) in dict {
            register[key.rawValue] = value
        }
        defaults().registerDefaults(register)
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

    var hogeHoge: String {
        get {
            return get(.hogeHoge) as! String
        } set(newValue) {
            set(newValue, forKey: .hogeHoge)
        }
    }

    var ddd: NSData {
        get {
            return get(.ddd) as! NSData
        } set(newValue) {
            set(newValue, forKey: .ddd)
        }
    }

    var i: Int {
        get {
            return get(.i) as! Int
        } set(newValue) {
            set(newValue, forKey: .i)
        }
    }

    var b: Bool {
        get {
            return get(.b) as! Bool
        } set(newValue) {
            set(newValue, forKey: .b)
        }
    }

    var f: Float {
        get {
            return get(.f) as! Float
        } set(newValue) {
            set(newValue, forKey: .f)
        }
    }

    var d: Double {
        get {
            return get(.d) as! Double
        } set(newValue) {
            set(newValue, forKey: .d)
        }
    }

    var ary: [AnyObject] {
        get {
            return get(.ary) as! [AnyObject]
        } set(newValue) {
            set(newValue, forKey: .ary)
        }
    }

    var dic: [String:AnyObject] {
        get {
            return get(.dic) as! [String:AnyObject]
        } set(newValue) {
            set(newValue, forKey: .dic)
        }
    }

    var day: NSDate {
        get {
            return get(.day) as! NSDate
        } set(newValue) {
            set(newValue, forKey: .day)
        }
    }

    var url: NSURL {
        get {
            return get(.url) as! NSURL
        } set(newValue) {
            set(newValue, forKey: .url)
        }
    }
}
',
                    empty: 'import Foundation

enum UserDefaultsRegister: String {
}

class UserDefaults {
    class func sharedManager() -> UserDefaults {
        struct Static {
            static let instance = UserDefaults()
        }
        return Static.instance
    }
    init() {
    }
    func registerDefaults(dict: [UserDefaultsRegister: AnyObject]) {
        var register: [String: AnyObject] = [:]
        for (key, value) in dict {
            register[key.rawValue] = value
        }
        defaults().registerDefaults(register)
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
}
',
                },
            },
        }
    end
end
