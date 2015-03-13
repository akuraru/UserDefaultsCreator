require 'spec_helper'

describe Udgenerator do
  it 'has a version number' do
    expect(Udgenerator::VERSION).not_to be "1.0.0"
  end

  before(:all) {
    @creater = Udgenerator::Core.new
  }
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

    before {
      @exchange = Udgenerator::c.map{|d| d[:exchange]}
    }
    context 'header' do
      it 'true' do
        expect(@creater.header(@exchange, "UserDefaults", true)).to eq '
#import <Foundation/Foundation.h>

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

- (id)url;
- (void)setUrl:(id)url;

@end
'
      end
      it 'false' do
        expect(@creater.header(@exchange, "UserDefaults", false)).to eq '
#import <Foundation/Foundation.h>

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

- (id)url;
- (void)setUrl:(id)url;

@end
'
      end
    end
    context 'method' do
      it 'true' do
        expect(@creater.method(@exchange, "UserDefaults", true)).to eq '#import "UserDefaults.h"

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

- (id)url {
    return [defaults objectForKey:kUrl];
}
- (void)setUrl:(id)url {
    [defaults setObject:url forKey:kUrl];
    [defaults synchronize];
}

@end
'
      end
      it 'false' do
        expect(@creater.method(@exchange, "UserDefaults", false)).to eq '#import "UserDefaults.h"

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

- (id)url {
    return [defaults objectForKey:kUrl];
}
- (void)setUrl:(id)url {
    [defaults setObject:url forKey:kUrl];
    [defaults synchronize];
}

@end
'
      end
    end
  end
end
