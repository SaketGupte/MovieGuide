//
// Generated by CocoaPods-Keys
// on 20/04/2017
// For more information see https://github.com/orta/cocoapods-keys
//

#import <objc/runtime.h>
#import <Foundation/NSDictionary.h>
#import "MovieGuideKeys.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"

@implementation MovieGuideKeys

  @dynamic movieDBClientKey;

#pragma clang diagnostic pop

+ (BOOL)resolveInstanceMethod:(SEL)name
{
  NSString *key = NSStringFromSelector(name);
  NSString * (*implementation)(MovieGuideKeys *, SEL) = NULL;

  if ([key isEqualToString:@"movieDBClientKey"]) {
    implementation = _podKeys4f501fe31380c8e0146a6c058d7e7c3d;
  }

  if (!implementation) {
    return [super resolveInstanceMethod:name];
  }

  return class_addMethod([self class], name, (IMP)implementation, "@@:");
}

static NSString *_podKeys4f501fe31380c8e0146a6c058d7e7c3d(MovieGuideKeys *self, SEL _cmd)
{
  
    
      char cString[33] = { MovieGuideKeysData[60], MovieGuideKeysData[862], MovieGuideKeysData[295], MovieGuideKeysData[845], MovieGuideKeysData[812], MovieGuideKeysData[380], MovieGuideKeysData[840], MovieGuideKeysData[534], MovieGuideKeysData[827], MovieGuideKeysData[447], MovieGuideKeysData[634], MovieGuideKeysData[574], MovieGuideKeysData[200], MovieGuideKeysData[167], MovieGuideKeysData[248], MovieGuideKeysData[576], MovieGuideKeysData[597], MovieGuideKeysData[721], MovieGuideKeysData[620], MovieGuideKeysData[297], MovieGuideKeysData[492], MovieGuideKeysData[792], MovieGuideKeysData[77], MovieGuideKeysData[198], MovieGuideKeysData[387], MovieGuideKeysData[86], MovieGuideKeysData[665], MovieGuideKeysData[736], MovieGuideKeysData[180], MovieGuideKeysData[291], MovieGuideKeysData[541], MovieGuideKeysData[354], '\0' };
    
    return [NSString stringWithCString:cString encoding:NSUTF8StringEncoding];
  
}


static char MovieGuideKeysData[898] = "HI+XAXBbSY2S6SG3nlINuD9mfHEfQ97uN4GywOKbAs6GHdPrtEpZtKwMEb+E3K1T6Z5yBUu6G9nwF9Hib4dvyH08IpL+Po3W4kvygUB8pELFQZJKudCoVHlmEbiNz1Ucq0TC0TOs2CnucS3oGcro4htNZZueXNMQMb4SP2t9BVArdCY7hNLv46moAvKwkALNWx1vrX4B7rfo6PUVd9ApcUU1L0+WCXwm3vZUmTbCN5O4jH8bOh/oC6890zKXF/dA/mG+HmuK+82hatuwNtjDSgjhaTUS2gbtWTj15EZ147Lw3gl+n8Hs+vkybR4dl+sRVkdZJyfjOrc9OfZNBnIgWZK5832/E6ewUC1HIjG464BvWrLkTcdvQmSh8ynQcea/g6Ma8u9j+zt9IGCWpSxXJOImLT/mREOc7sXqqT5OSSgSUio0+vzD6i7PuEbCONO70edkyZnYtLp5hVV6Wh15A4dWHe1PN+tlQ3KQUiXKUmVy5MllmH5s6pvD/pJEq61Co8xE4F5s5bFsmmSbuDC6kP6O3r5mL9WN49Ft4goDjwxO7qJNdErTko6e1lGjLA7gatODOQv4zgrwZ1ronMlDocwx/rcRriHsGVwt0C6VLZgh07NY+jmvDLTIu83abUqNm0tNx1baT1sQKugwgiz4qZx0Iae+k9/BnL8Cr9SNkTO2TOUs5JLfJrxMMSkMOZzKAp5BJWJu1VMX5/cki9RCuK4wodYRY76N7DY91yVmQvn92as5g4mqUv+3+XCzix4rMqUMjgNyVjSl3o7nEriK05o152nLS1c+OIWIyqYy0K0V0WGaDpOwc4DHkd72JlJhrbtrl6Vl0fuwpbbaoiirBHMwVG28Zv5jbTleqPV3TTiEkOK7z/5mpJtn6NP7odIu\\\"";

- (NSString *)description
{
  return [@{
            @"movieDBClientKey": self.movieDBClientKey,
  } description];
}

- (id)debugQuickLookObject
{
  return [self description];
}

@end