//
//  REAutoCompleteTests.m
//  REAutoCompleteTests
//
//  Created by Rinat Enikeev on 07/25/2016.
//  Copyright (c) 2016 Rinat Enikeev. All rights reserved.
//

#import <REAutoComplete/REAutoComplete.h>

@interface NSString (REAutoCompleteItem) <REAutoCompleteItem>
@end

@implementation NSString (REAutoCompleteItem)
- (NSString*)autoCompleteText {
    return self;
}
@end

@import XCTest;

@interface Tests : XCTestCase
@property (strong, nonatomic) NSArray<NSString*>* sampleData;
@end

@implementation Tests

- (void)setUp
{
    [super setUp];
    self.sampleData = @[@"abc", @"zabc", @"def", @"geh"];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testAutoCompleteAlgorithmContains
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"Sample data auto complete items for \"abc\" has two items: \"abc\" and \"zabc\""];
    
    REAutoCompleteAlgorithmContains* algorithm = [[REAutoCompleteAlgorithmContains alloc] initWithSuggestions:self.sampleData];
    [algorithm suggestionsFor:@"abc" whenReady:^(NSArray<id<REAutoCompleteItem>> * _Nonnull suggestions) {
        XCTAssertEqual(suggestions.count, 2);
        XCTAssertEqual(suggestions[0], @"abc");
        XCTAssertEqual(suggestions[1], @"zabc");
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if(error) {
            XCTFail(@"Expectation Failed with error: %@", error);
        }
    }];
}

@end

