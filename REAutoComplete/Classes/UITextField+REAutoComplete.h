//
//  UITextField+REAutoComplete.h
//  Pods
//
//  Created by Rinat Enikeev on 25/07/16.
//
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class REAutoComplete;

@protocol RESuggestionItem <NSObject>
- (NSString *)suggestionText;
@end

@protocol REAutoCompleteAlgorithm <NSObject>
- (void)suggestionsFor:(NSString*)query whenReady:(void (^)(NSArray<id<RESuggestionItem>>* suggestions))callback;
@optional
- (instancetype)initWithSuggestions:(NSArray<id<RESuggestionItem>>*)suggestions;
@end

@protocol REAutoCompleteDelegate <UITextFieldDelegate>
@optional

- (void)autoComplete:(REAutoComplete*)autoComplete didSelectObject:(id<RESuggestionItem>)object;

- (void)autoCompleteWillAppear:(REAutoComplete*)autoComplete;
- (void)autoCompleteWillDissapear:(REAutoComplete*)autoComplete;

#pragma mark - Cell
- (void)autoComplete:(REAutoComplete*)autoComplete configureCell:(UITableViewCell *)cell withObject:(id<RESuggestionItem>)object;
- (CGFloat)autoComplete:(REAutoComplete*)autocomplete heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_CLASS_AVAILABLE_IOS(8_0) @interface REAutoComplete : NSObject
@property (strong, nonatomic) id<REAutoCompleteAlgorithm> algorithm;
@property (strong, nonatomic) id<REAutoCompleteDelegate> delegate;
@property (assign, nonatomic) NSUInteger minimumCharacters;

// Appearance
@property (strong, nonatomic, readonly) UITableView *tableView;
@property (assign, nonatomic) CGFloat tableViewHeight;
@property (assign, nonatomic) BOOL keyboardAccessory;

@end

@interface UITextField(REAutoComplete)

@property (strong, nonatomic, nonnull, readonly) REAutoComplete* autoComplete;

@end

NS_ASSUME_NONNULL_END
