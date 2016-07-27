//
//  REAutoCompleteAlgorithmContains.m
//  Pods
//
//  Created by Rinat Enikeev on 25/07/16.
//
//

#import "REAutoCompleteAlgorithmContains.h"

@interface REAutoCompleteAlgorithmContains ()
@property (strong, nonatomic) NSArray<id<REAutoCompleteItem>>* suggestions;
@end

@implementation REAutoCompleteAlgorithmContains

- (instancetype)init {
    self = [self initWithSuggestions:nil];
    return self;
}

- (instancetype)initWithSuggestions:(NSArray<id<REAutoCompleteItem>> *)suggestions {
    self = [super init];
    if (self) {
        self.suggestions = suggestions;
    }
    return self;
}

- (void)suggestionsFor:(NSString *)query whenReady:(void (^)(NSArray<id<REAutoCompleteItem>> *suggestions))callback {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableArray *array = self.suggestions.mutableCopy;
        if (query.length > 0) {
            NSPredicate* predicate = [NSPredicate predicateWithFormat:@"autoCompleteText CONTAINS[cd] %@", query];
            [array filterUsingPredicate:predicate];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            callback(array);
        });
    });
}

@end
