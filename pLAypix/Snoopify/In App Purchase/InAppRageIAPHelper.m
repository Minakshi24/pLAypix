

#import "InAppRageIAPHelper.h"

@implementation InAppRageIAPHelper

static InAppRageIAPHelper * _sharedHelper;

+ (InAppRageIAPHelper *) sharedHelper {
    
    if (_sharedHelper != nil) {
        return _sharedHelper;
    }
    _sharedHelper = [[InAppRageIAPHelper alloc] init];
    return _sharedHelper;
    
}

- (id)init 
{
    
    NSSet *productIdentifiers = [NSSet setWithObjects:@"Set1", nil];
    
    if ((self = [super initWithProductIdentifiers:productIdentifiers])) {                
        
    }
    return self;
    
}

@end
