//
//  REAutoCompleteAlgorithmContains.h
//  Pods
//
//  Created by Rinat Enikeev on 25/07/16.
//
//

#import <Foundation/Foundation.h>
#import "UITextField+REAutoComplete.h"

@interface REAutoCompleteAlgorithmContains : NSObject<REAutoCompleteAlgorithm>

- (instancetype)initWithSuggestions:(NSArray<id<REAutoCompleteItem>>*)suggestions NS_DESIGNATED_INITIALIZER;

@end
