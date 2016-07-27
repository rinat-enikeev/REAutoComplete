//
//  REDataProvider.h
//  REAutoComplete
//
//  Created by Rinat Enikeev on 27/07/16.
//  Copyright © 2016 Rinat Enikeev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <REAutoComplete/REAutoComplete.h>

@interface NSString (REAutoCompleteItem) <REAutoCompleteItem>
@end

@interface REDataProvider : NSObject

+ (REDataProvider*)sharedProvider;

- (NSArray<id<REAutoCompleteItem>>*)countriesArray;

@end
