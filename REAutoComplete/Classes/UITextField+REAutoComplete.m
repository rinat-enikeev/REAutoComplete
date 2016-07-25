//
//  UITextField+REAutoComplete.m
//  Pods
//
//  Created by Rinat Enikeev on 25/07/16.
//
//

#import <objc/runtime.h>
#import "UITextField+REAutoComplete.h"

@implementation UITextField(REAutoComplete)

static char _autoComplete;

- (REAutoComplete*)autoComplete {
    id autoComplete = objc_getAssociatedObject(self, &_autoComplete);
    if (autoComplete == nil) {
        autoComplete = [[REAutoComplete alloc] init];
    }
    return autoComplete;
}

- (void)setAutoComplete:(REAutoComplete *)autoComplete {
    objc_setAssociatedObject(self, &_autoComplete, autoComplete, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end


@implementation REAutoComplete

@end