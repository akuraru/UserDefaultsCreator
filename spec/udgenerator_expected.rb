
module Udgenerator
	def self.expected
		{
			header: {
				true: '#import <Foundation/Foundation.h>

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
				false: '#import <Foundation/Foundation.h>

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
			},
			method: {
				true: '#import "UserDefaults.h"

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
				false: '#import "UserDefaults.h"

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
			},
			swift: {
				true: 'import Foundation

struct UserDefaultsRegister {
    static let hogeHoge = "hogeHoge"
    static let ddd = "ddd"
    static let i = "i"
    static let b = "b"
    static let f = "f"
    static let d = "d"
    static let ary = "ary"
    static let dic = "dic"
    static let day = "day"
    static let url = "url"
}

class UserDefaults {
    class func sharedManager() -> UserDefaults {
        struct Static {
            static let instance = UserDefaults()
        }
        return Static.instance
    }
    init() {
        defaults().registerDefaults([
            UserDefaultsRegister.hogeHoge: "",
            UserDefaultsRegister.i: 0,
            UserDefaultsRegister.b: false,
            UserDefaultsRegister.f: 0,
            UserDefaultsRegister.d: 0,
            UserDefaultsRegister.day: NSDate(),
        ])
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

    func hogeHoge() -> String {
        return get(UserDefaultsRegister.hogeHoge) as String
    }
    func setHogeHoge(hogeHoge: String) {
        set(hogeHoge, forKey: UserDefaultsRegister.hogeHoge)
    }

    func ddd() -> NSData {
        return get(UserDefaultsRegister.ddd) as NSData
    }
    func setDdd(ddd: NSData) {
        set(ddd, forKey: UserDefaultsRegister.ddd)
    }

    func i() -> Int {
        return get(UserDefaultsRegister.i) as Int
    }
    func setI(i: Int) {
        set(i, forKey: UserDefaultsRegister.i)
    }

    func b() -> Bool {
        return get(UserDefaultsRegister.b) as Bool
    }
    func setB(b: Bool) {
        set(b, forKey: UserDefaultsRegister.b)
    }

    func f() -> Float {
        return get(UserDefaultsRegister.f) as Float
    }
    func setF(f: Float) {
        set(f, forKey: UserDefaultsRegister.f)
    }

    func d() -> Double {
        return get(UserDefaultsRegister.d) as Double
    }
    func setD(d: Double) {
        set(d, forKey: UserDefaultsRegister.d)
    }

    func ary() -> NSArray {
        return get(UserDefaultsRegister.ary) as NSArray
    }
    func setAry(ary: NSArray) {
        set(ary, forKey: UserDefaultsRegister.ary)
    }

    func dic() -> NSDictionary {
        return get(UserDefaultsRegister.dic) as NSDictionary
    }
    func setDic(dic: NSDictionary) {
        set(dic, forKey: UserDefaultsRegister.dic)
    }

    func day() -> NSDate {
        return get(UserDefaultsRegister.day) as NSDate
    }
    func setDay(day: NSDate) {
        set(day, forKey: UserDefaultsRegister.day)
    }

    func url() -> NSURL {
        return get(UserDefaultsRegister.url) as NSURL
    }
    func setUrl(url: NSURL) {
        set(url, forKey: UserDefaultsRegister.url)
    }
}
',
				false: 'import Foundation

struct UserDefaultsRegister {
    static let hogeHoge = "hogeHoge"
    static let ddd = "ddd"
    static let i = "i"
    static let b = "b"
    static let f = "f"
    static let d = "d"
    static let ary = "ary"
    static let dic = "dic"
    static let day = "day"
    static let url = "url"
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
    func registerDefaults(dict: [String: AnyObject]) {
        defaults().registerDefaults(dict)
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

    func hogeHoge() -> String {
        return get(UserDefaultsRegister.hogeHoge) as String
    }
    func setHogeHoge(hogeHoge: String) {
        set(hogeHoge, forKey: UserDefaultsRegister.hogeHoge)
    }

    func ddd() -> NSData {
        return get(UserDefaultsRegister.ddd) as NSData
    }
    func setDdd(ddd: NSData) {
        set(ddd, forKey: UserDefaultsRegister.ddd)
    }

    func i() -> Int {
        return get(UserDefaultsRegister.i) as Int
    }
    func setI(i: Int) {
        set(i, forKey: UserDefaultsRegister.i)
    }

    func b() -> Bool {
        return get(UserDefaultsRegister.b) as Bool
    }
    func setB(b: Bool) {
        set(b, forKey: UserDefaultsRegister.b)
    }

    func f() -> Float {
        return get(UserDefaultsRegister.f) as Float
    }
    func setF(f: Float) {
        set(f, forKey: UserDefaultsRegister.f)
    }

    func d() -> Double {
        return get(UserDefaultsRegister.d) as Double
    }
    func setD(d: Double) {
        set(d, forKey: UserDefaultsRegister.d)
    }

    func ary() -> NSArray {
        return get(UserDefaultsRegister.ary) as NSArray
    }
    func setAry(ary: NSArray) {
        set(ary, forKey: UserDefaultsRegister.ary)
    }

    func dic() -> NSDictionary {
        return get(UserDefaultsRegister.dic) as NSDictionary
    }
    func setDic(dic: NSDictionary) {
        set(dic, forKey: UserDefaultsRegister.dic)
    }

    func day() -> NSDate {
        return get(UserDefaultsRegister.day) as NSDate
    }
    func setDay(day: NSDate) {
        set(day, forKey: UserDefaultsRegister.day)
    }

    func url() -> NSURL {
        return get(UserDefaultsRegister.url) as NSURL
    }
    func setUrl(url: NSURL) {
        set(url, forKey: UserDefaultsRegister.url)
    }
}
',
			},
		}
	end
end
