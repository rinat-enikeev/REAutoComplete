//
//  REDataSourceViewController.m
//  REAutoComplete
//
//  Created by Rinat Enikeev on 27/07/16.
//  Copyright © 2016 Rinat Enikeev. All rights reserved.
//

#import "REDataSourceViewController.h"
#import <REAutoComplete/REAutoComplete.h>
#import "REDataProvider.h"

@interface REDataSourceViewController () <REAutoCompleteDelegate, REAutoCompleteDataSource>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@end

@implementation REDataSourceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textField.autoComplete.dataSource = self;
    // all UITextFieldDelegate calls are forwarded to autoComplete.delegate
    self.textField.autoComplete.delegate = self;
    self.textField.autoComplete.tableViewTopMargin = 5;
    self.textField.autoComplete.tableViewBottomMargin = 5;
    self.textField.autoComplete.tableViewAutoHeight = YES;
}

#pragma mark <REAutoCompleteDataSource>
- (void)autoComplete:(REAutoComplete*)autoComplete suggestionsFor:(NSString*)query whenReady:(void (^)(NSArray<id<REAutoCompleteItem>>* suggestions))callback {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableArray *array = [[[REDataProvider sharedProvider] countriesArray] mutableCopy];
        if (query.length > 0) {
            NSPredicate* predicate = [NSPredicate predicateWithFormat:@"autoCompleteText BEGINSWITH[cd] %@", query];
            [array filterUsingPredicate:predicate];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            callback(array);
        });
    });
}

#pragma mark <REAutoCompleteDelegate>
- (void)autoComplete:(REAutoComplete*)autoComplete didSelectObject:(id<REAutoCompleteItem>)object {
    self.textField.text = [object autoCompleteText];
    [self.textField resignFirstResponder];
}

#pragma mark <UITextFieldDelegate>
// all UITextFieldDelegate calls are forwarded to autoComplete.delegate
-(BOOL)textFieldShouldClear:(UITextField *)textField
{
    NSLog(@"TextField cleared");
    return YES;
}

@end
